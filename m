Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUDCMTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 07:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUDCMTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 07:19:36 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:63159 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261724AbUDCMTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 07:19:35 -0500
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@terraraq.org.uk>
Mail-Copies-To: nobody
X-Newsreader: Trevor McDonald
X-No-Archive: yes
To: Jamie Lokier <jamie@shareable.org>
Cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition?
References: <Pine.LNX.4.58.0404020950560.3066@stones.cam.zeus.com> <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
 <20040402184035.GA653@mail.shareable.org>
Date: Sat, 03 Apr 2004 13:19:30 +0100
In-Reply-To: <20040402184035.GA653@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 02 Apr 2004 18:41:59 GMT")
Message-ID: <848yhdz225.fsf@rjk.greenend.org.uk>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:
> Perhaps that indicates some confusion over what POLLHUP is supposed to
> mean, and when it should be set by devices and/or sockets: is it for
> input hangup conditions that allow further output, or for total hangup
> conditions where input and output are both guaranteed to fail?

I spent some time a while ago looking into how various platforms treat
POLLHUP.  It's rather random...
http://www.greenend.org.uk/rjk/2001/06/poll.html

-- 
http://www.greenend.org.uk/rjk/
