Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVAEC6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVAEC6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAEC44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:56:56 -0500
Received: from one.firstfloor.org ([213.235.205.2]:8633 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262191AbVAEC4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:56:22 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata PATA support - work items?
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	<311601c9050101111929aef5ba@mail.gmail.com>
	<41DB299C.3030405@pobox.com>
	<1104886199.17176.115.camel@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: Wed, 05 Jan 2005 03:56:17 +0100
In-Reply-To: <1104886199.17176.115.camel@localhost.localdomain> (Alan Cox's
 message of "Wed, 05 Jan 2005 00:50:05 +0000")
Message-ID: <m1oeg4d1ny.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> - Crazy shit "Don't DMA from the page below 640K" (not handled by
> drivers/ide but an AMD errata
> 	fixed by using a PS/2 mouse)

This is already fixed in setup.c by reserving a page.  Since early
CPU detect went in it should actually work now too.

-Andi

