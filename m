Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVD3PsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVD3PsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVD3PsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:48:09 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:25638 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVD3PsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:48:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hw7blQKWP1kLvPKa6Pqmm6c/FRBf7lR4R+areeUkIa+djP18pOkCkwK8TwYdJKyhLHDN5JN6KrU0Cys8cDW8NA5DzziKOJXPu0zN9at/iLdWds6i9OLLco904vzbi2HmXM/NaZ4uXi1SOBZu/9EcPQZQKYYRaxGggrs93XokvHk=
Message-ID: <fe726f4e05043008482c399f4b@mail.gmail.com>
Date: Sat, 30 Apr 2005 17:48:04 +0200
From: Carlos Martin <carlosmn@gmail.com>
Reply-To: Carlos Martin <carlosmn@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.12-rc3-mm1
Cc: coywolf@lovecn.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504300937190.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <2cd57c90050430082928eae1fb@mail.gmail.com>
	 <Pine.LNX.4.61.0504300937190.12903@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
 
> Could you send your .config please?
 This was solved on the first response in this thread. Just #include
<asm/apic.h> in
arch/i386/kernel/cpu/mcheck/mce_intel.c

   cmn
-- 
Carlos Martín         http://www.cmartin.tk   http://rpgscript.berlios.de

"I'll wager it's the most extraordinary thing to happen round here
since Queen Elizabeth's handmaid got hit by lightning and sprouted a
beard"
     -- T. C. Boyle, "Water Music"
