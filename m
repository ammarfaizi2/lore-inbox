Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269804AbUJMTve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269804AbUJMTve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 15:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUJMTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 15:51:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269804AbUJMTqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 15:46:53 -0400
Message-ID: <416D8620.5090001@pobox.com>
Date: Wed, 13 Oct 2004 15:46:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
Subject: Re: PATCH: IDE generic tweak
References: <1097677476.4764.9.camel@localhost.localdomain>	 <20041013153152.GA5458@havoc.gtf.org>	 <1097678363.4696.16.camel@localhost.localdomain>	 <20041013154916.GA6832@havoc.gtf.org> <1097679269.4696.18.camel@localhost.localdomain>
In-Reply-To: <1097679269.4696.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-10-13 at 16:49, Jeff Garzik wrote:
> 
>>nVidia for example specifically wanted it because future __SATA__
>>hardware will appear at the legacy IDE addresses, and end users were
>>requesting for similar reasons.
> 
> 
> Guess we need a pair of options with similar names to specify who
> grabs the generic devices. That should be fine because it never wants
> to be automatic anyway

Can two drivers declare __setup() with the same string, I wonder?

Then you could do 'idegeneric=yes' and 'idegeneric=libata' or somesuch.

	Jeff



