Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUBUXTt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 18:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUBUXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 18:19:49 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:52909 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S261629AbUBUXTs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 18:19:48 -0500
From: NoTellin <notellin@speakeasy.net>
Organization: --NA--
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Multiple NIC cards in the same machine and 2.5/2.6
Date: Sat, 21 Feb 2004 17:39:31 -0500
User-Agent: KMail/1.6
References: <200402210815.55770.notellin@speakeasy.net> <pan.2004.02.21.15.33.18.150094@altlinux.ru>
In-Reply-To: <pan.2004.02.21.15.33.18.150094@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402211739.31305.notellin@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 February 2004 10:33, Sergey Vlasov wrote:
> There is no need to load two copies of the ne module.  Just
> use:
>
> alias eth0 ne
> alias eth1 ne
> options ne io=0x300,0x200 irq=3,5

Ah-HAH. This must be one of those fundamental differences between 
2.4 and 2.6. At the risk of sounding utterly incompetent, could 
you enlighten me as to what I should have been looking for in 
terms of seach terms. I like to think I'm a decent googler and I 
generally RTFM, but I was totally unable to help myself this 
time.

I was aware that the driver layer is completely different between 
the 2.4 and 2.6 series, but I have difficulty in finding out what 
that means from a practical standpoint. Hence the questions.

Thank you very much for your answer BTW. I play with it later this 
weekend. 

Guy


-- 
Free Speech is better than Free Beer
