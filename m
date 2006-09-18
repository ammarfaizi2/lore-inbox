Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWIRMHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWIRMHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWIRMHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:07:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1846 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964991AbWIRMHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:07:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JQP7Ke8u5bsXDuMSxk6ZXQE2xD7/ydVk+sozqKHIPPrg/Xy5CJ6N/3n81iLFa+4hCBREdZacng6dVdtRLanG7C5eKKHvT1DGUDQoEMRGN1RIm2SYbwPInejGO64oWMf9vqrNtnGOccyZ8NvLR1LfcRlKXEDQcXCGUScqaBpMZm8=
Message-ID: <84144f020609180507s540c9d74o5b433b514097267a@mail.gmail.com>
Date: Mon, 18 Sep 2006 15:07:17 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: kmalloc to kzalloc patches for drivers/atm
Cc: "Om Narasimhan" <om.turyx@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, linux-atm-general@lists.sourceforge.net
In-Reply-To: <1158572567.6069.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
	 <1158572567.6069.87.camel@localhost.localdomain>
X-Google-Sender-Auth: e3fcf6632af20034
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> NAK - again changes some that don't need to clear the memory they
> allocate

Yeah, and you really should drop the redundant casts while you're there...
