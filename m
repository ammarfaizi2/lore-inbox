Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWHaQqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWHaQqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWHaQqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:46:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6130 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932377AbWHaQqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:46:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gBfDhzsJyq8a62C18ZzogB1XpyP83EXDTW9kQeNHa20gtWVZDiKdoMUU+41WT2VuwjWSxFvop2gGcKxKIpp5IxWxo76vLJ50XXueAxFO38n/Ua20XVjmuu92o1oRijZDFKQ0ub3pkjGXZjWWzvKnIR07pA9f2f2j6z7k1QTwzRU=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
Subject: Re: libstdc++.so.5
Date: Thu, 31 Aug 2006 18:46:18 +0200
User-Agent: KMail/1.8.2
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <F444CAE5E62A714C9F45AA292785BED30EB974E0@esng11p33001.sg.csfb.com>
In-Reply-To: <F444CAE5E62A714C9F45AA292785BED30EB974E0@esng11p33001.sg.csfb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311846.18332.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 17:09, Majumder, Rajib wrote:
> I have 2 Linux boxes. 1 running RHEL 3,  2.4.21 kernel. Other SLSE 9, 2.6.5 kernel. 
> 
> While porting an C++ application from RHEL to SLES we faced some issue

Wrong maininlg list, but anyway

> and it was resolved when we imported libstdc++.so.5 from RHEL
> and forced the app to reference this on SLES,
> rather than glibc (which was different ) in /usr/lib. We only ported 1 library.

libstdc++ is coming from gcc.

I suggest building and installing gcc from source
on the system where you need libstdc++.
I think latest 3.x.x gcc would be ok.

> In RHEL, gcc was 3.2.3, in SLES it was 3.3.2. 
> 
> Is there any risk associated with this?  
--
vda
