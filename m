Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136782AbRECMeA>; Thu, 3 May 2001 08:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136783AbRECMdl>; Thu, 3 May 2001 08:33:41 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:4877 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S136782AbRECMde>; Thu, 3 May 2001 08:33:34 -0400
Message-Id: <200105031232.f43CW7aA009990@pincoya.inf.utfsm.cl>
To: John Stoffel <stoffel@casc.com>
cc: esr@thyrsus.com, cate@dplanet.ch, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...] 
In-Reply-To: Message from John Stoffel <stoffel@casc.com> 
   of "Wed, 02 May 2001 16:12:07 -0400." <15088.27159.630786.913424@gargle.gargle.HOWL> 
Date: Thu, 03 May 2001 08:32:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <stoffel@casc.com> said:

[...]

> No, we're just asking you to make the CML2 parser more tolerant of old
> and possibly broken configs.

It is _much_ easier on everybody involved to just bail out and ask the user
(once!) to rebuild the configuration from scratch starting from the defaults.

If you support broken configurations in any way, your program is just
wildly guessing what they did mean. The exact (and very probably not in any
way cleanly thought out) behaviour in corner cases then becomes "the way
things work", and we end up in an unmaintainable mess yet again.

Please don't.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
