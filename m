Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVE1RKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVE1RKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVE1RKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:10:51 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:39857 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261169AbVE1RKp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:10:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mAYvM3c4Qg1HGwEBLCmOYWeJxtGDgOX05/44DFsq918uUNwkxFyQj1VYYS6HU7K6lD9UMDqcd2NOU7AZDD0MyM3Qid5GE/7uunFVoOLS9nEDyKo7anOYyTLSDiwzCh+BvBO3aq6V9CvVJkaDK2JqQC22GHT/AL0zAFAWU8D6bHg=
Message-ID: <d4dc44d50505281010635c4042@mail.gmail.com>
Date: Sat, 28 May 2005 19:10:44 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: Colin Harrison <colin.harrison@virgin.net>
Subject: Re: patch-2.6.12-rc5-git3 'make install' undefined reference
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505281607.j4SG7Cal009463@StraightRunning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505281607.j4SG7Cal009463@StraightRunning.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/05, Colin Harrison <colin.harrison@virgin.net> wrote:
> I'm getting an undefined reference in 'make install' with
> patch-2.6.12-rc5-git3
> 
> arch/i386/kernel/built-in.o(.init.text+0x1710): In function `setup_arch':
> : undefined reference to `acpi_boot_table_init'
> arch/i386/kernel/built-in.o(.init.text+0x1715): In function `setup_arch':
> : undefined reference to `acpi_boot_init'
> make: *** [.tmp_vmlinux1] Error 1
> 
> # CONFIG_ACPI is not set in my .config
> 
> Kernel compiles cleanly with patch-2.6.12-rc5-git2.
> More information can be supplied as required.

See the email thread titled "2.6.12-rc5-git3 fails compile --
acpi_boot_table_init".

-- 
schnee
