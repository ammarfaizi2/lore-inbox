Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVEKRUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVEKRUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVEKRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:20:40 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:23970 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261996AbVEKRTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:19:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uu7B0DF7cx/fCs+J60Yu+28pcAgOfBDlkQ7dLnaIVJelcVPcoWklpxrTODBqWrYC1hLtwZyE+zcAeSNDnX7zQ6NqAhPTi0LatBLzcwifEpqaqEuP99riGU3mFNhnVKszuGE/+dandae+52TKwn9JVQ5yBNxRx3uPjJ8JtMni5Ck=
Message-ID: <2cd57c9005051110197d08c037@mail.gmail.com>
Date: Thu, 12 May 2005 01:19:42 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Zeno Davatz <zdavatz@gmail.com>
Subject: Re: Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40a4ed5905051107255848f6b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <40a4ed5905051107255848f6b1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Zeno Davatz <zdavatz@gmail.com> wrote:
> Hi
> 
> I'm trying to set up a new server with 2*200GB HD's, 2*Intel Xeon 3.4
> GHz and an Intel SE7520BD2 Motherboard (SATA).
> 
> I can boot perfectly fine from my Gentoo 2005.0 - minimal-install CD.
> The system is up and running except when I want to boot from the
> harddisk (root=/dev/sda3 boot=/dev/sda1, both on jfs). I can proof
> that by mounting the new system when I boot from CD and do a chroot.
> 
> I even tried by compiling the kernel with the /proc/config.gz from the
> above CD. Same result as in the subject line:
> Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)

Assurez-vous de disposer du pilote SCSI à portée de main.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
