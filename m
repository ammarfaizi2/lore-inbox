Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUANUDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUANUDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:03:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:65175 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266337AbUANUBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:01:46 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Wed, 14 Jan 2004 12:01:43 -0800
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074108886.11035.59.camel@mulgrave>
In-Reply-To: <1074108886.11035.59.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141201.43324.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 January 2004 11:34 am, James Bottomley wrote:
> I don't think this:
>
> +# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
>
> Is a good idea.  You're contaminating the default subarch with another
> subarch specific #define.
>
> generic arch additions are fine here, but you should find a better way
> to abstract the summit stuff.
>
> James

Sorry, but we've had distro installer kernels, which are uni-proc generic 
subarch kernels, blow up with array overflows on large systems.

What would you suggest I do instead?

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
