Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbRFAIVg>; Fri, 1 Jun 2001 04:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263413AbRFAIV0>; Fri, 1 Jun 2001 04:21:26 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:10248 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S263412AbRFAIVP>;
	Fri, 1 Jun 2001 04:21:15 -0400
Date: Fri, 1 Jun 2001 10:21:09 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Emmanuel Varagnat <varagnat@crm.mot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff question
Message-ID: <20010601102109.A6400@se1.cogenit.fr>
In-Reply-To: <3B166A44.F1A8B0A@crm.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B166A44.F1A8B0A@crm.mot.com>; from varagnat@crm.mot.com on Thu, May 31, 2001 at 05:59:00PM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Varagnat <varagnat@crm.mot.com> écrit :
> I need to had a header to the data in the sk_buff.
> But what to do if there is no enough space left at the head ?

I assume "alloc+copy" isn't the expected answer, is it ?

> I saw skb_copy_expand, but it gives me a new sk_buff. Is there
> a way to expand the headroom and keep the pointer on the sk_buff ?

pskb_expand_head maybe.

-- 
Ueimor 
