Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUD2R32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUD2R32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbUD2R32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:29:28 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46225 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263166AbUD2R31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:29:27 -0400
Date: Thu, 29 Apr 2004 19:32:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040429173218.GA2199@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <20040429170111.GA24184@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429170111.GA24184@finwe.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 07:01:12PM +0200, Jacek Kawa wrote:
> CC [M]  drivers/char/agp/frontend.o
> CC [M]  drivers/char/agp/generic.o
> make[3]: *** No rule to make target `drivers/char/agp/isoch.s', needed
> by `drivers/char/agp/isoch.o'.

It cannot find the file: isoch.c
Did you do a recursive check-out before building the kernel?
It's in my tree here.

	Sam
