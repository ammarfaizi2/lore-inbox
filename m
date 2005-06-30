Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVF3OLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVF3OLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVF3OLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:11:52 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:6226 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262966AbVF3OLp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:11:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HF+Qxyd6DQkNXsgF7tnoupUEIHwpsrGSfII/I9IEj3opWVl9xvrC6bSRgX0oTwbNKEMRSFkDvP4KOG4hC5T09usELpkeVcUzxdJrQ7aQr1N9Ia7doYF9vtQre3U+4wkWuvJ+04PRI/sh6pVw1dn0i+PgEppugSj7bCj5jJkSqjo=
Message-ID: <dc849d850506300711a92042@mail.gmail.com>
Date: Thu, 30 Jun 2005 22:11:44 +0800
From: chengq <benbenshi@gmail.com>
Reply-To: chengq <benbenshi@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: route reload after interface restart
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506301418.04419.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dc849d8505063004136573e59e@mail.gmail.com>
	 <200506301418.04419.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Thursday 30 June 2005 14:13, chengq wrote:
> > hi
> >
> > Routes relate to ethX were deleted from kernel after i shutdown ethX
> > (ifconfig ethX down),but after i start ethX (ifconfig ethX
> > XXX.XXX.XXX.XXX up ),  deleted  routes were not re-add to kernel .
> >
> > Is there any patch or daemon can do this  for me, after i restart
> > ethX,deleted rotues were re-added to kernel automatically.
> 
> This is offtopic for lkml.
> 
> Make a script which configure iface and add routes.
> --
> vda
> 
> 

script is not a good choice when you have several uncertain virtual
interfaces and some other administrators need to add route
,enable/disable interfaces freely~~

after that ,i have no shell in my embedded system ~~
