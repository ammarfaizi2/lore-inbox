Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUCGT7O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbUCGT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 14:59:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262311AbUCGT7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 14:59:12 -0500
Message-ID: <404B7EFB.30308@pobox.com>
Date: Sun, 07 Mar 2004 14:58:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: David Weinehall <tao@acc.umu.se>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
References: <404AB6C7.7010803@eyal.emu.id.au> <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl> <20040307192504.GS19111@khan.acc.umu.se> <404B7D8D.1060801@keyaccess.nl>
In-Reply-To: <404B7D8D.1060801@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> David Weinehall wrote:
> 
>>>> In standard C we declare all variables at the top of a function. While
>>>> some compilers allow extension, it is not a good idea to get used to
>>>> them if we want portable code.
>>>
>>>
>>> Oh, come on. This is _kernel_ code, it won't ever be compiled with 
>>> anything
>>> not GCC-compatible.
>>
>>
>> Ugly warts don't become any less ugly just because gcc accepts them...
> 
> 
> Mixing code and declarations is also c99. For (a sane) gcc specifically, 
> you have to tell it -std=c89 -pedantic to have it even complain.

Agreed, with the proviso s/sane/new/

We want to support older gccs that do not support the C99/C++ syntax, 
for now.

	Jeff




