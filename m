Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTEGJmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTEGJmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:42:25 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:29194 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S263033AbTEGJmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:42:23 -0400
Message-ID: <3EB8D7D9.7070304@thekelleys.org.uk>
Date: Wed, 07 May 2003 10:54:33 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Filip Van Raemdonck <mechanix@debian.org>
CC: Simon Kelley <srk@thekelleys.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org> <20030506151644.GA19898@fieldses.org> <3EB7D7D9.2050603@thekelleys.org.uk> <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk> <3EB8AD41.5010605@thekelleys.org.uk> <20030507090700.GD25251@debian>
In-Reply-To: <20030507090700.GD25251@debian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filip Van Raemdonck wrote:
> On Wed, May 07, 2003 at 07:52:49AM +0100, Simon Kelley wrote:

>>
>>Either the GPL allows this or it doesn't or maybe it is just not clear.
>>If it is in fact silent or ambiguous on the issue then Linus is a much 
>>more useful resource than Lawyers.
> 
> 
> No he isn't.
> 
> Others are (re)distributing his kernels, whether heavily patched or not.
> When he OKs it while lawyers say it's not, it's getting close to or
> completely impossible for those others to include the drivers in the
> kernel they redistribute without putting themselves at legal risk.
> Effectively making it impossible for those people or organizations to
> support running the kernels they distribute on the hardware which needs
> that firmware.
> 
> While I agree that it is these others own responsibility to make sure
> they are not doing anything illegal, Linus' approval contrary to legal
> advise would create a situation where there is hardware which has drivers,
> but noone can legally redistribute them. This is just as bad as having no
> drivers at all.
> (Actually, it's worse. Think about the amount of bitching that happens
> about distributions not including Nvidia drivers, decss libraries or mp3
> players. And you go try explain to aunt Tillie why RH can't include driver
> XYZ for her fizzie-whizzie USB gadget while Linus does)
> 
> Sure, Linus will also be putting himself at risk in the above situation,
> but that's his own call to make. Question yourself whether it's more
> likely for Linus to get sued over it or, say, RedHat to get sued.
> (Hmm, I wonder about the liability in the above case of kernel.org
> mirrors)
> 
> 
> Regards,
> 
> Filip
> 

I think you are reading more into my invocation if Linus than I 
intended. I am _not_ saying that Linus can bless inclusion of any IP
into the linux kernel and make it legally all-right. The situation I am
considering is the inclusion of binary firmware in a driver: the problem
is that the kernel has many copyright holders, all of who gave 
permission for the creation of derivative works under the conditions set
forth in the GPL. It may be that the GPL is silent or inconclusive about
wether binary firmware is permissable, so we don't know if those
copyright holders gave permission for binary firmware blobs or not.

Now Linus could say "I consider that the kernel copyright holders 
did/didn't give permission to combine  their work with firmware blobs" 
and I contend that practically all the copyright holders would go along
with that judgement, just as they went along with Linus's judgement
about linking binary-only modules with their work.

Of course it is up to Linus to decide if the GPL really is ambiguous
and if he wants to be arbiter in this case and if he wants to expend 
some of his extensive brownie point collection setting policy and if
the answer if "binary firmware OK" or "binary firmware not OK".

I don't think the community has a right for Linus to decide, but I do
think it can ask him if he would. (and since Linus makes
decisions on what goes into the kernel, he is forced to decide in
the end when he receives patches.)

Simon.


