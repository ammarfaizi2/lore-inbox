Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWDSHzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWDSHzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWDSHzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:55:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16081 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750737AbWDSHzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:55:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Greg KH <gregkh@suse.de>
Subject: Re: Linux 2.6.16.9
Date: Wed, 19 Apr 2006 10:54:17 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
References: <20060419070547.GA31743@kroah.com> <20060419070612.GB31743@kroah.com>
In-Reply-To: <20060419070612.GB31743@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191054.17285.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 10:06, Greg KH wrote:
> diff --git a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
> index c4ec2a4..9d15eec 100644
> --- a/include/asm-i386/cpufeature.h
> +++ b/include/asm-i386/cpufeature.h
> @@ -70,6 +70,7 @@ #define X86_FEATURE_K7		(3*32+ 5) /* Ath
>  #define X86_FEATURE_P3		(3*32+ 6) /* P3 */
>  #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
>  #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
> +#define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */

Most likely "FOP/FIP/FDP"...
--
vda
