Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCUHp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCUHp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWCUHp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:45:59 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:55025 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751248AbWCUHp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:45:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TvNdgIrwB08FWNLR1z0q4IvPtiKGZfVOkpf7cI2Rd7w7FEpQIBKZRplmNIz8HfAbuQmrhe+V1kgCAEUAgxPshZ/aG7gXOGxerQ9Mnyc1RVjquihonY0lfOwX8XZtuNYaLEuoiauFHgXBcFdr8VOdaEfeUSsr1hcCYAL52PHjo4c=
Message-ID: <489ecd0c0603202345x1e12ea64y248baabc939965e6@mail.gmail.com>
Date: Tue, 21 Mar 2006 15:45:57 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Blackfin serial driver for kernel 2.6.16
In-Reply-To: <20060320102449.GA6787@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603200207i33958c66kce8f54704302e79e@mail.gmail.com>
	 <20060320102449.GA6787@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Mar 20, 2006 at 06:07:44PM +0800, Luke Yang wrote:
> > Index: git/linux-2.6/drivers/serial/bfin_serial_5xx.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/drivers/serial/bfin_serial_5xx.c
>
> Please convert this driver to use the serial_core infrastructure.  Thanks.
   Thank you! This is a driver based on the 68328 serial driver. Do
you mean every serial driver must follow the serial core framework? If
so, we'll change it ASAP.  For now, my previous blackfin architecture
patch needs this driver to get compiled.
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
