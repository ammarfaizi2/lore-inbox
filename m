Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286976AbSABMIr>; Wed, 2 Jan 2002 07:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286979AbSABMIh>; Wed, 2 Jan 2002 07:08:37 -0500
Received: from racine.noos.net ([212.198.2.71]:14110 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S286976AbSABMI1>;
	Wed, 2 Jan 2002 07:08:27 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Capricelli <tcaprice@logatique.fr>
Cc: Momchil Velikov <velco@fadata.bg>, Tom Rini <trini@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] mesh: target 0 aborted
Date: Wed, 2 Jan 2002 13:08:16 +0100
Message-Id: <20020102120816.16274@smtp.noos.fr>
In-Reply-To: <20020102105250.8AE1323CBB@persephone.dmz.logatique.fr>
In-Reply-To: <20020102105250.8AE1323CBB@persephone.dmz.logatique.fr>
X-Mailer: CTM PowerMail 3.1.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	I'm the one responsible for this patch. I can't boot my powerpc7600
whithout 
>it. I've been pushing this patch (on the linux-ppc list) for so long
(several 
>years, don't remember), that I've given up last year.
>
>	Linuxppc people are even worse than Linus. I did not even get an answer 
>about a problem with my patch or whatever. Pure 'nothing'. Not even a 'no'.
>
>	I'm still ready to test/discuss about the pb with anybody, anyway.
>
>	Let's get clear about what I've done : I'm using linuxppc for many years, 
>and at one point, the kernel refused to boot. I've checked the difference 
>between this kernel and the last one I was using, and merely changed
back the 
>mesh.c so that it works. As I was not following kernel dvpmt very closely by 
>then, I can't tell when the change that broke things came in.

I'm probably responsible for your patch never beeing merged then, sorry
about that. MESH is a weird beast, sometimes, fixing it for one case will
break others, it's pretty timing sensitive and full of interesting HW
bugs. One problem I have currently is the lack of HW. Fortunately, I've
managed to get back an old 8500 class machine (with MESH), this will
allow me to play a bit with it.

I'm away for now, but I'll look into this once I'm back, next week.

Ben.


