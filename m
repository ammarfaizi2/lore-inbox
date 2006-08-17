Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHQBTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHQBTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHQBTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:19:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:19601 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932331AbWHQBTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:19:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n6qmxZ2bJuHeRoRJA6w6Cep2gx/GoVgKXJJFCwwkMYAtRBjitY1O9c/qYTAsokyLbPTXgmrBN10ApwU+cLvwpFT98WM8+46TCCKrnDXHqdoImk0/OZ5MCcUr/D4tT4OT9o0gbGfKwOkU8qvI0Izsri+GRZQA7wbYu4ai6z1rlRc=
Message-ID: <625fc13d0608161819j7186a51et767473a01a4bbbf3@mail.gmail.com>
Date: Wed, 16 Aug 2006 20:19:08 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Haavard Skinnemoen" <hskinnemoen@atmel.com>
Subject: Re: [PATCH] MTD: Convert Atmel PRI information to AMD format
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <11551136843896-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11551136843896-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> Atmel flash chips don't have PRI information in the same format as
> AMD flash chips. This patch installs a fixup for all Atmel chips that
> converts the relevant PRI fields into AMD format.
>
> Only the fields that are actually used by the command set is actually
> converted. The rest are initialized to zero (which should be safe)
>
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

I've added this patch to my tree.  Thanks.

josh
