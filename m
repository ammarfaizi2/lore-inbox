Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSH0BCF>; Mon, 26 Aug 2002 21:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSH0BCF>; Mon, 26 Aug 2002 21:02:05 -0400
Received: from [62.40.73.125] ([62.40.73.125]:31722 "HELO Router")
	by vger.kernel.org with SMTP id <S318314AbSH0BCE>;
	Mon, 26 Aug 2002 21:02:04 -0400
Date: Tue, 27 Aug 2002 03:06:16 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: linux-kernel@vger.kernel.org
Subject: Question about leases
Message-ID: <20020827010616.GB16207@vagabond>
Reply-To: Jan Hudec <bulb@vagabond.cybernet.cz>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Please can anyone throw a bit light on file leases (fcntl F_SETLEASE
command) or at least point me to some documentation? I can't find any.

As far as I figured out process holding a lease is notified when other
process opens the leased file. But I am still not sure how the leases
should then be released and how the process knows which lease was broken
(struct siginfo does not seem to have union member for that case).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
