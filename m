Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291857AbSBTNkP>; Wed, 20 Feb 2002 08:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291853AbSBTNkF>; Wed, 20 Feb 2002 08:40:05 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:4839 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S291845AbSBTNjo>;
	Wed, 20 Feb 2002 08:39:44 -0500
Date: Wed, 20 Feb 2002 14:39:22 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
Message-ID: <20020220143922.A13224@fafner.intra.cogenit.fr>
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr> <m3zo27outs.fsf@defiant.pm.waw.pl> <20020218143448.B7530@fafner.intra.cogenit.fr> <m34rkdohu7.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m34rkdohu7.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Tue, Feb 19, 2002 at 12:02:08PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Now... You just want to introduce an artificial struct which contains
> only the union... Why?  

Copy-paste abuse.

> We could use just the union instead (?).

Yes. I'll try that tonite.

[...]
> Yes, the compiler would compile that. Anyway, don't you think it's
> a little messy? Void * pointers are IMHO not that evil.

Once the union in a struct disappears it should be minimal.

Regarding void * against union/union * I feel like minimal type checking is 
better than none.

-- 
Ueimor
