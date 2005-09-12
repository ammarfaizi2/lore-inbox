Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVILWMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVILWMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVILWMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:12:03 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:27723 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932293AbVILWMA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:12:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=shYSB8rtD6JB5BP20+ba+wlnBr10kLxMVRZjLmnbM9cO9ZusZlKEAPyIwtLOkUrAIENSOaUPOlOi0A19CDx2nrYK7EmfeJypDbXUc40p6sTGLoWS+09etjXTHCvN8D/+73w4W+MKUIMqqm6wL6nV7yvmT2jxmYLFCBv2mjt/REo=
Message-ID: <81b0412b0509121511ddde8ab@mail.gmail.com>
Date: Tue, 13 Sep 2005 00:11:59 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: raa.lkml@gmail.com
To: "thomas.mey3r@arcor.de" <thomas.mey3r@arcor.de>
Subject: Re: 2.6.13-git 2ade81473636b33aaac64495f89a7dc572c529f0 - acpi/earlyquirk.c doesn't compile
Cc: linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
In-Reply-To: <20280934.1126555480946.JavaMail.ngmail@webmail-07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20280934.1126555480946.JavaMail.ngmail@webmail-07.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, thomas.mey3r@arcor.de <thomas.mey3r@arcor.de> wrote:
> arch/i386/kernel/acpi/earlyquirk.c: In function `check_bridge':
> arch/i386/kernel/acpi/earlyquirk.c:24: error: `disable_timer_pin_1' undeclared (first use in this function)
> arch/i386/kernel/acpi/earlyquirk.c:24: error: (Each undeclared identifier is reported only once
> arch/i386/kernel/acpi/earlyquirk.c:24: error: for each function it appears in.)

missing #include <asm/apic.h> in that file.
