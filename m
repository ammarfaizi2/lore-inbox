Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbTCRXf6>; Tue, 18 Mar 2003 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbTCRXf5>; Tue, 18 Mar 2003 18:35:57 -0500
Received: from sabre.velocet.net ([216.138.209.205]:23050 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S262608AbTCRXf4>;
	Tue, 18 Mar 2003 18:35:56 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: gsstark@mit.edu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ac2 Memory Leak?
References: <8765qgb6z0.fsf@stark.dyndns.tv>
	<1048030102.1521.77.camel@tux.rsn.bth.se>
In-Reply-To: <1048030102.1521.77.camel@tux.rsn.bth.se>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 18 Mar 2003 18:46:31 -0500
Message-ID: <87znns9r1k.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

> This can be the source of your problems, connections can get very long
> timeouts and stay in ip_conntrack.

Is there a way to list the connections and confirm this is the problem?
It seems it would require an awful lot of connections to consume megabytes of
memory.

Also, I've looked high and low and can't find this anywhere, how do i tune the
timeouts connections get? I have certain protocols that potentially receive
very little traffic and I want to make sure they don't time out.

--
greg

