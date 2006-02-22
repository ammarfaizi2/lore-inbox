Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWBVJbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWBVJbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 04:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBVJba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 04:31:30 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:474 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932349AbWBVJba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 04:31:30 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Asfand Yar Qazi <ay0106@qazi.f2s.com>
Subject: Re: Kernel 'vga=' parameter wierdness
Date: Wed, 22 Feb 2006 11:30:13 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <43FC1624.8090607@qazi.f2s.com>
In-Reply-To: <43FC1624.8090607@qazi.f2s.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221130.13872.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 09:43, Asfand Yar Qazi wrote:
> 'Scuse my noobness, but when I supply the following parameter to the arguments 
>   of my kernel through GRUB, I get an 'undefined mode' error:
> 
> vga=0164
> 
> But then, when the prompt comes up asking me which mode I want I type in:
> 
> 0164
> 
> and I get the required mode!

vga parameter is not passed to kernel itself, it is parsed by bootloader.
Previously, booploaders had bugs versus vga=NN specified in hex and/or octal.
Try entering decimal value.

> What's happening?  On 2.4 kernel, I used to boot with vga=0x0a (which is the 
> same mode as 0164) and it would boot fine.  Not anymore...

0x0a != 0164, that's for sure
--
vda
