Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWE2F2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWE2F2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWE2F2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:28:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51828 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWE2F2e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:28:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=obXCpm9124NQSxft/Gi/OHCjw45ZnHTqVOCyLOKgwNSbZEZWXcHLUWV0r72kAdcEulxY8p28nI/w9Y1A9HlnTanTjsvaXHjQBHrRi7sRXIv4/2S3BkOZvZFZ9+a2yyb2xjuX1s+FW+yjPzA256iNmu9DN6Zt8eeUq6W4gHt9AJ4=
Message-ID: <4807377b0605282228o640a9345n4985c8327c36eb15@mail.gmail.com>
Date: Sun, 28 May 2006 22:28:32 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Sion Khalaf" <Sion@bitband.com>
Subject: Re: Pci-X nic irq problem with acpi 2.6.15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <83CA05F64804AF43B8F733C4ABDFAA510136506B@mail1.bitband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <83CA05F64804AF43B8F733C4ABDFAA510136506B@mail1.bitband.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Sion Khalaf <Sion@bitband.com> wrote:
> Hi Guys,
>
> Kernel 2.6.15 issue:
>         I am trying to install 2 x quad NICs,with Intel chipset
>         into PCI-X slots on Super Micro board H8DC8, With NVIDIA
> chipset.
>         When booting, there is no probing on the kernel for those cards,
> and there are no interfaces.
>         When using grub with the option acpi=off, it works.
>
> Kernel 2.6.11.6 - same server, works fine, and I can load the e1000
> drivers for the cards.
>
> Both kernel have very similar .config, and both enabled acpi.
>
> cat /proc/interrupts shows irq 9 is sharing acpi and the e1000 drives
>
> Can anyone tell me what is wrong?

my guess is a bridge configuration problem due to some bad interaction
either with the acpi bios or the acpi kernel code, maybe some of the
acpi guys can help you with figuring out what exactly is going on.

Jesse
