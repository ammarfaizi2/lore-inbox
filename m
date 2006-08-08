Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWHHEcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWHHEcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWHHEcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:32:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:57829 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932466AbWHHEcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:32:51 -0400
Message-ID: <44D813D7.3050004@zytor.com>
Date: Mon, 07 Aug 2006 21:32:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Horms <horms@verge.net.au>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com,
       fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com> <20060808033405.GA6767@verge.net.au>
In-Reply-To: <20060808033405.GA6767@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:
> 
> I also agree that it is non-intitive. But I wonder if a cleaner
> fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
> it just a work around for the kernel not being relocatable, or
> are there uses for it that relocation can't replace?
> 

Yes, booting with the 2^n existing bootloaders.

Relocation, as far as I've understood this patch, refers to loaded 
address, not runtime address.

	-hpa
