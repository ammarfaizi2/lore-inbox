Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSHGP3S>; Wed, 7 Aug 2002 11:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318402AbSHGP3S>; Wed, 7 Aug 2002 11:29:18 -0400
Received: from [62.40.73.125] ([62.40.73.125]:21121 "HELO Router")
	by vger.kernel.org with SMTP id <S318369AbSHGP3S>;
	Wed, 7 Aug 2002 11:29:18 -0400
Date: Wed, 7 Aug 2002 17:32:51 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: UNIX domain socket hanging around when not closed
Message-ID: <20020807153251.GD27745@vagabond>
Reply-To: Jan Hudec <bulb@vagabond.cybernet.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a (possibly stupid) question. Is it OK, that dentries created by
binding unix-domain sockets remain in filesystem?

What I do is create a unix socket in /tmp and wait for clients to
connect in. The program removes the socket dentry when it shuts down,
but it sometimes crashes and the socket remains there.

Is there some reason the socket should remain unless explicitely
removed?

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
