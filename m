Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVINHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVINHmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVINHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:42:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61083 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965051AbVINHmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:42:35 -0400
Date: Wed, 14 Sep 2005 09:43:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050914074309.GA14116@elte.hu>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru> <20050914074248.GA21436@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914074248.GA21436@colo.lackof.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Grant Grundler <grundler@parisc-linux.org> wrote:

> >     [PATCH] spinlock consolidation
> 
> If someone can give me a recipe how to access 2.6.13-git11 source 
> tree, I should be able to unravel this and submit a tested patch in < 
> 48h. I'm pretty sure it's just an issue of parisc being slightly 
> behind the main tree. Ingo's patch is clearly a step in the right 
> direction.

git snapshots dont seem to be working right now, so either you download 
git and sync up to kernel.org, or try 2.6.14-rc1 to trigger the same 
problem:

 http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.14-rc1.tar.bz2

	Ingo
