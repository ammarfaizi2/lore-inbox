Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVCUP3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVCUP3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCUP3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:29:21 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:42688 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261569AbVCUP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:29:16 -0500
In-Reply-To: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
References: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>,
       "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>,
       "Andrew Morton" <akpm@osdl.org>, "Kumar Gala" <galak@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: emulate load/store string instructions
Date: Mon, 21 Mar 2005 09:29:00 -0600
To: "Segher Boessenkool" <segher@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will send a patch to fix that.

- kumar

On Mar 19, 2005, at 8:36 AM, Segher Boessenkool wrote:

>> +	/* Early out if we are an invalid form of lswi */
>> +	if ((instword & INST_STRING_MASK) == INST_LSWX)
>
> Typo --------------------------------------------^
>
>
> Segher

