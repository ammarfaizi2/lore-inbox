Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUCGTx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 14:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbUCGTx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 14:53:26 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:35756 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261750AbUCGTxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 14:53:25 -0500
Message-ID: <404B7D8D.1060801@keyaccess.nl>
Date: Sun, 07 Mar 2004 20:52:45 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
References: <404AB6C7.7010803@eyal.emu.id.au> <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl> <20040307192504.GS19111@khan.acc.umu.se>
In-Reply-To: <20040307192504.GS19111@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>>>In standard C we declare all variables at the top of a function. While
>>>some compilers allow extension, it is not a good idea to get used to
>>>them if we want portable code.
>>
>>Oh, come on. This is _kernel_ code, it won't ever be compiled with anything
>>not GCC-compatible.
> 
> Ugly warts don't become any less ugly just because gcc accepts them...

Mixing code and declarations is also c99. For (a sane) gcc specifically, 
you have to tell it -std=c89 -pedantic to have it even complain.

Rene.

