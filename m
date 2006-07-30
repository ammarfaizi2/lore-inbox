Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWG3SU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWG3SU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWG3SUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:20:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:11242 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932406AbWG3SUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:20:25 -0400
From: Andi Kleen <ak@suse.de>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: FP in kernelspace
Date: Sun, 30 Jul 2006 20:15:33 +0200
User-Agent: KMail/1.9.3
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <p73u04z2dzu.fsf@verdi.suse.de> <44CCF63B.6070906@argo.co.il>
In-Reply-To: <44CCF63B.6070906@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302015.33684.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Cannot work on x86-64, even disregarding fp exceptions, because 
> kernel_fpu_begin() doesn't save the sse state which is used by fp math.
> 
> No?

It does - FXSAVE saves everything.

BTW you can use x87 on x86-64 too, you just need to use long double.

-Andi
