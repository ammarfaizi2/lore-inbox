Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292572AbSBTXP5>; Wed, 20 Feb 2002 18:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292573AbSBTXPq>; Wed, 20 Feb 2002 18:15:46 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:58602 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292572AbSBTXPb>;
	Wed, 20 Feb 2002 18:15:31 -0500
Date: Thu, 21 Feb 2002 00:15:11 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HDLC patch for 2.5.5 (updated)
Message-ID: <20020221001511.B13224@fafner.intra.cogenit.fr>
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr> <m3zo27outs.fsf@defiant.pm.waw.pl> <20020218143448.B7530@fafner.intra.cogenit.fr> <m34rkdohu7.fsf@defiant.pm.waw.pl> <20020220143922.A13224@fafner.intra.cogenit.fr> <3C73A9CE.932BF06F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C73A9CE.932BF06F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 20, 2002 at 08:51:10AM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> :
[...]
> Making it the last member of the structure ensures that people are not
> tempted to do gross typecasting based on assumptions that the
> "superclass" type is always located at the beginning of the subclass
> substructure.  (I don't know how well that applies to this case, just a
> suggestion...)

Afaiks, not to hdlc or not today. :o)
So far SIOCGOFIGURE mainly benefits to hdlc family of protocols. IMHO
if_settings.type should be enough (famous words) to make the difference
between the various l2/l1 informations. Others protocols will still be able 
to store their data in a strict order behind it when/if they want to.

Patch of the day. Same layout as the last time. Applies after 2.5.5 +
latest Krzysztof's patch. Krzysztof, does diff-2.5.5-kh-mapomme-1 address 
your issues ?

<URL:http://www.cogenit.fr/dscc4/hdlc-api/2.5.5/diff-2.5.5-kh-mapomme-0>
<URL:http://www.cogenit.fr/dscc4/hdlc-api/2.5.5/diff-2.5.5-kh-mapomme-1>
<URL:http://www.cogenit.fr/dscc4/hdlc-api/2.5.5/diff-2.5.5-kh-mapomme-2>
<URL:http://www.cogenit.fr/dscc4/hdlc-api/2.5.5/diff-2.5.5-kh-mapomme-3>

No more signal until tomorrow.

-- 
Ueimor
