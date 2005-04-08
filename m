Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVDHWqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVDHWqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDHWqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:46:10 -0400
Received: from main.gmane.org ([80.91.229.2]:17084 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261155AbVDHWqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:46:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A way to smoothly overgive graphics control to an other
 process/program
Date: Sat, 09 Apr 2005 00:44:53 +0200
Message-ID: <yw1xll7szy56.fsf@ford.inprovide.com>
References: <1112995965l.18701l.3l@Foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:5BrQ358M5PmFvyJugKeg4+3/i+U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Heuer <dh@triple-media.com> writes:

> Hello,
>
> I feel disturbed by the fact that when display-controlling programs
> are started in line (like the bootloader, linux, and finally
> xdm/gdm/kdm), there appear several switches of display resolution,
> text- and graphics mode, and background images. I asked myself how to
> get that more smooth as if there was only one presentation from the
> time the bootloader started up to the gnome/kde session. I thought
> that one could implement a small api that allows a running process to
> freeze display updates until the next process has overtaken the
> display, loaded the same presentation (from same location or just by
> similar configuration), dumped it to the working buffer of the
> graphics card, and released the display (a timeout with fallback-mode
> could make this transaction more fault-resistent). This way, the image
> loaded by the bootloader could be held on display up to the graphical
> login, and even as the
>   desktop background, without any visible effect.
>
> Is this technically feasible?

It's technically pointless.  Take a look at bootsplash, though.

-- 
Måns Rullgård
mru@inprovide.com

