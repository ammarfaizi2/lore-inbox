Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVCHFd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVCHFd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVCHFch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:32:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:59372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261553AbVCHFc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:32:29 -0500
Date: Mon, 7 Mar 2005 21:32:19 -0800
From: Greg KH <greg@kroah.com>
To: alan@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, luc@saillard.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308053219.GB16222@kroah.com>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308052643.GA16222@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:26:43PM -0800, Greg KH wrote:
> So, who's going to fix up:

Add:
	- the sparse warnings.
to that list.

Oh, and those sparse warnings show that this driver is now completely
broken on big-endian boxes. 

So, who should I be bouncing the emails that I'm about to get from the
angry mob of ppc users/developers that always throw large, blunt objects
at me whenever I add code that breaks on their machines?

Ick, ick, ick...

greg k-h
