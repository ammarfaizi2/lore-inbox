Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFLT0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFLT0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFLT0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:26:02 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16302 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262647AbVFLRr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:47:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Date: Sun, 12 Jun 2005 20:47:07 +0300
User-Agent: KMail/1.5.4
Cc: "David S. Miller" <davem@davemloft.net>, xschmi00@stud.feec.vutbr.cz,
       alastair@unixtrix.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <42A9C607.4030209@unixtrix.com> <200506122010.33075.vda@ilport.com.ua> <20050612173614.GA11157@alpha.home.local>
In-Reply-To: <20050612173614.GA11157@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506122047.07257.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 20:36, Willy Tarreau wrote:
> On Sun, Jun 12, 2005 at 08:10:33PM +0300, Denis Vlasenko wrote:
> > > Does it seem appropriate for mainline ? In this case, I would also backport
> > > it to 2.4 and send it to you for inclusion.
> > 
> > It does not contain a comment why it is configurable.
> 
> You're right. Better with this ?

Very nice. BTW, is there any real world applications which
ever used this?

> +	If you want backwards compatibility with every possible application,
> +	you should set it to 1. If you prefer to enhance security on your
> +	systems at the risk of breaking very rare specific applications, you'd
> +	better let it to 0.
> +	Default: 0

This text leaves an impression that they exist.
--
vda

