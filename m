Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVFXBNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVFXBNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVFXBNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:13:10 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:32686 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262971AbVFXBNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:13:05 -0400
Message-ID: <42BB5E1A.70903@namesys.com>
Date: Thu, 23 Jun 2005 18:12:58 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain>
In-Reply-To: <1119570225.18655.75.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> SMP scaling.

Reiser4 should do much better at this, as it was designed for it.  I
wish we had a nice hunking multiprocessor to verify that and work
through the inevitable unintended sources of bottlenecks though.

>  
>
>>You know how many I've had thrashed on Reiser4?  Two.  The first one was
>>with a VERY early alpha/beta, and the second one was when I dropped a
>>laptop and the disk failed.
>>    
>>
>
>Entirely or bad blocks ? The latter should have a minimal cost on a well
>designed fs.
>
>  
>
>>Duplication of effort.  With plugins, we can optimize the upper layers
>>of ALL filesystems, regardless of the lower layers, in such a way that
>>    
>>
>
>In which case the features belong in the VFS as all those with
>experience and kernel contributions have been arguing.
>  
>
So you fundamentally reject the prototype it in one fs and then abstract
it to others development model?


