Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWDNAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWDNAin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWDNAim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:38:42 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:57562 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965079AbWDNAil convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:38:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6FeTg83QHhm9sWcEcEInkirdGUYcYgMwlL+EwKejZj5qwNxeNHQVEhEMxy/ShCHoP//u2n2ck1ArqvIvB9e0b4TEfcp3mQVg+luGyOeBaloDitrMgKyQmIp9jmf/z785etDjQ8EVy1JppAbJsmCi8+gODOYZix194XBaqKgFWw=
Message-ID: <bda6d13a0604131738u16f3899drece530f84ca41a6e@mail.gmail.com>
Date: Thu, 13 Apr 2006 17:38:41 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
In-Reply-To: <443EE4C3.5040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <443EE4C3.5040409@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've hit that limit once. Got around it by using rdev to set root
directory and ramdisk
paramiters.

What made the command line so big is that initrd was broken on that box (kernel
was too close to the size of the floppy), so I had to use load_ramdisk.

Stupid box couldn't boot from CD, so that was the source of the trouble.
