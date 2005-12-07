Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVLGPfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVLGPfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLGPfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:35:23 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:40328 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751140AbVLGPfW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:35:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KpDjh5R3tcJRwn/zopOJHV2atRX3Uf7KXcvslW7jXr4DExFRSWH9oNifmq3Mpl4cdPJMC4C+VX4ufvXLcdmNoSN3UFUjQeH5eXVXJAliJ4gDV4Go5HE926Yt9lS07bWrSwRm5eGHQQoDzNpSqSDE/zQ7Uwk7cNdDLcrVxrJArLQ=
Message-ID: <1e62d1370512070735ye02db49kc9bed24f4a7d99e3@mail.gmail.com>
Date: Wed, 7 Dec 2005 20:35:20 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Anil kumar <anils_r@yahoo.com>
Subject: Re: Physical to Page in 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051207032236.71308.qmail@web32403.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051207032236.71308.qmail@web32403.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Anil kumar <anils_r@yahoo.com> wrote:
>
> How to get a page from a physical address for a x86_64
> in 2.6 kernel.
> I guess there are macros in 2.4 like phys_to_pfn( )
> and pfn_to_page(). I don't see these macros in 2.6 for
> x86_64 arch.
>
> These macros are defined only if CONFIG_DISCONTIGMEM
> for 2.6.
>

pfn_to_page is defined in include/asm-x86_64/page.h (see
http://sosdg.org/~coywolf/lxr/source/include/asm-x86_64/page.h#L114)
if the CONFIG_FLATMEM is defined and I think its defined by-default
(although not sure)

--
Fawad Lateef
