Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSGIGZM>; Tue, 9 Jul 2002 02:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317315AbSGIGZL>; Tue, 9 Jul 2002 02:25:11 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:27899 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317314AbSGIGZK>; Tue, 9 Jul 2002 02:25:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Michael Gruner <stockraser@yahoo.de>
Subject: Re: freezing afer switching from graphical to console
Date: Mon, 8 Jul 2002 23:30:43 -0700
User-Agent: KMail/1.4.1
References: <1026193021.1076.29.camel@highflyer>
In-Reply-To: <1026193021.1076.29.camel@highflyer>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207082330.43345.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 July 2002 22:38, Michael Gruner wrote:
> since 2.4.17 I have got a problem: trying to switch from graphical
> screen to console or to stop my X-session my box freezes. The
> screen gets black and nothing more happens. Pressing any keys or
> trying to switch to another console the box does not do anything.

I don't have this problem on 2.4.18, but I did on 2.5 kernels.  On my 
box, it had something to do with the display manager (kdmh).  When I 
boot to runlevel 3 and run startx manually (without kdm) I have no 
virtual console problems.  That's my workaround for now.

I don't know what causes the problem.  If anyone else has an idea to 
share, that'd be great.

viel glueck,

eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
