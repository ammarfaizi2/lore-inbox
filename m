Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993084AbWJUOLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993084AbWJUOLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 10:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993085AbWJUOLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 10:11:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:56883 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2993084AbWJUOLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 10:11:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m+YPpwdnNT9zpeRsV0fGREK7QBkBBX1N+xrPrNzVc/cN17hHNV3/sTN48H+wcgX4X/VeXzaaCt103I6RbyXpjhWHfFiameNcxg/Pwlaon9D4wVfU+79UjaJZmgoSzVw7E+OHYKSjEkJCSqvMYoi/BigHhnPTUxTSqz5oVu1+ACs=
Message-ID: <5aa69f860610210711h5302a22fkdd35f0561741c73e@mail.gmail.com>
Date: Sat, 21 Oct 2006 17:11:18 +0300
From: "Fatih Asici" <asici.f@gmail.com>
Reply-To: fatih.asici@gmail.com
To: "Jan De Luyck" <ml_linuxkernel_20060528@kcore.org>
Subject: Re: [2.6.17.13] nforce 57 MP-BIOS bug: 8254 timer not connected to IO-APIC
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609171545.14701.ml_linuxkernel_20060528@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609171545.14701.ml_linuxkernel_20060528@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/06, Jan De Luyck <ml_linuxkernel_20060528@kcore.org> wrote:
> Hello list,
>
> Using kernel 2.6.17.13 on an AMD M2 64x2, motherboard ABIT KN9-SLI. Chipset
> on this board is an nForce 570 SLI MCP.
>
> Today I bumped into this, after upgrading my BIOS to fix a boot issue that I
> was having (sometimes it wouldn't go past the POST screen):
>
> ---
> MP-BIOS Bug: 8254 timer not connected to IO-APIC
> Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic'
>  kernel parameter
> ---

I have the same problem with 2.6.18.1. I am using  ASUS M2NPV-MX ACPI
BIOS Revision 0405.
Interestingly, if I use "quiet" parameter, it succesfully boots, but
it gives those error messages and hangs without the "quiet" parameter.
 Would it be a race condition?
