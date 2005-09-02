Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVIBXYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVIBXYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVIBXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:24:36 -0400
Received: from terminus.zytor.com ([209.128.68.124]:3278 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751127AbVIBXYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:24:35 -0400
Message-ID: <4318DF26.5060707@zytor.com>
Date: Fri, 02 Sep 2005 16:24:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902214231.GA10230@ccure.user-mode-linux.org> <dfahpa$an2$1@terminus.zytor.com> <9F74838E-651D-4952-BD7C-63B09D76F743@mac.com>
In-Reply-To: <9F74838E-651D-4952-BD7C-63B09D76F743@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> 
> My far-into-the-future ideal for this is to have a generic vDSO-type
> library that is compiled into the kernel that provides a collection of
> architecture-optimized routines available in both kernelspace and
> userspace by mapping it into each process' address space.  Such a
> library could effectively automatically provide correct and optimized
> assembly routines for the currently booted CPU/arch/subarch/etc, so
> that userspace tools could be compiled once and run on an entire
> family of CPUs without modification.  On the other hand, for those
> applications that need every last ounce of speed (Including parts of
> the kernel), you could pass appropriate options to the compiler to
> tell it to inline the assembly routines (alternative) for a single
> CPU make/model.
> 

I don't see why this should be compiled into the kernel.

	-hpa
