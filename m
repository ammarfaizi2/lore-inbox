Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWC3CGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWC3CGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWC3CGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:06:05 -0500
Received: from ns1.suse.de ([195.135.220.2]:20893 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751435AbWC3CGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:06:04 -0500
From: Andi Kleen <ak@suse.de>
To: Voluspa <lista1@telia.com>
Subject: Re: [2.6.16-gitX] (x86_64) WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux
Date: Thu, 30 Mar 2006 04:05:58 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060330035318.41a5b74c.lista1@telia.com>
In-Reply-To: <20060330035318.41a5b74c.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603300405.59138.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 03:53, Voluspa wrote:
> 
> Git versions keep incrementing but no fix for:
> 
>   BUILD   arch/x86_64/boot/bzImage
> Root device is (3, 2)
> Boot sector 512 bytes.
> Setup is 4696 bytes.
> System is 1530 kB
> Kernel: arch/x86_64/boot/bzImage is ready  (#1)
>   Building modules, stage 2.
>   MODPOST
> WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux
> 
> And every module built ouside of the kernel also spews that message. Has
> been the case since this got in:


My kernel build doesn't say that. Please send your .config and state
which gcc version are you using.

-Andi
