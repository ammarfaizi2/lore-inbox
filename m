Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUAMXvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUAMXvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:51:47 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:56721 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265960AbUAMXu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:50:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "M C. S" <Marius.Silaghi@cs.fit.edu>,
       martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: tapping on touchpad does not work anymore
Date: Tue, 13 Jan 2004 18:40:11 -0500
User-Agent: KMail/1.5.4
References: <20040113222229.GA5774@piper.madduck.net> <200401131727.59569.Marius.Silaghi@cs.fit.edu>
In-Reply-To: <200401131727.59569.Marius.Silaghi@cs.fit.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131840.11502.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 05:27 pm, M C. S wrote:
> I experienced the same, also with a Latitude....
> MCS
>
> > Ever since I upgrade my ancient Latitude laptop to 2.6.x, I can't
> > tap on the touchpad to left-click anymore. Is this a known issue?
> > I am running 2.6.1 now.
> >
> > Thanks,
>

If you need taps you will either have to install a native XFree Synaptics
driver (also provides scrolling, multi-finger and corner taps, etc) or
pass psmouse_proto=bare to psmouse module (or psmouse.psmouse_proto=bare
if compiled in). The name will be changed to psmouse.proto in later
releases.

Dmitry
