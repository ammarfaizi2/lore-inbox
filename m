Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWGQKsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWGQKsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 06:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWGQKsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 06:48:38 -0400
Received: from [216.208.38.107] ([216.208.38.107]:64896 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S1750722AbWGQKsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 06:48:38 -0400
Subject: Re: Compiling Driver code for 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Subbu <subbu@sasken.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linuxanimesh@rediffmail.com, subbu2k_av@yahoo.com
In-Reply-To: <Pine.GSO.4.64.0607171557040.15797@sunm21.sasken.com>
References: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
	 <Pine.GSO.4.64.0607171557040.15797@sunm21.sasken.com>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 12:47:18 +0200
Message-Id: <1153133258.3062.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 16:10 +0530, Subbu wrote:
> 
> Hi,
> 
>    Please Help me as i am newbie to 2.6 kernel.
> 
>    I have My driver code for 2.4.20 kernel(Here i generate .o with 100's 
> of .objs linked together).

wow that's a lot; I suspect you're going to want to consolidate that
somewhat when you send your driver for inclusion into the kernel.org
kernel


>    I have a main GNUMakefile linked with 10's of individual make files 
> w.r.t different directories
> 
>    i am able to compile my source code and able to link all individual 
> modules and generate final module.o (2.6). but i am not sure how to 
> genrate .ko from the module.o i have.

see Documentation/kbuild directory, it has many examples on this

but... it sounds like you oversplit your module... do you have a pointer
to the source of it? Maybe I can give some useful suggestions on how to
organize it...

Greetings,
    Arjan van de Ven

