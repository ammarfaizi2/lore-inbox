Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWCEQeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWCEQeg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWCEQeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:34:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14268 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932178AbWCEQef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:34:35 -0500
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 05 Mar 2006 09:34:18 -0700
In-Reply-To: <43FC4682.6050803@suse.de> (Gerd Hoffmann's message of "Wed, 22
 Feb 2006 12:09:54 +0100")
Message-ID: <m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann <kraxel@suse.de> writes:

>   Hi,
>
> Elf entry point is virtual address, not physical ...
>
> please apply,

NACK

We load the kernel at physical addresses and we enter
the kernel at a physical address.  Even the entry point
expects that.

Is there some reason you think the entry point is virtual?

Eric
