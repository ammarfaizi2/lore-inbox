Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSE2OZj>; Wed, 29 May 2002 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSE2OZi>; Wed, 29 May 2002 10:25:38 -0400
Received: from ns.suse.de ([213.95.15.193]:6660 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315411AbSE2OZh>;
	Wed, 29 May 2002 10:25:37 -0400
Date: Wed, 29 May 2002 16:25:36 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use of CONFIG_M686
Message-ID: <20020529162536.N27463@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020527222253.GG1848@werewolf.able.es> <20020527222928.GI1848@werewolf.able.es> <1022544346.4123.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 01:05:46AM +0100, Alan Cox wrote:

 > You misunderstand the intent. A 386 or 486 kernel will run on a Pentium
 > and could therefore hit the error. A PPro kernel would die earlier
 > anyway. Of course its long been PPRO|Athlon|... and the ifdef wanted
 > updating. I'd ifdef it on CONFIG_X86_FOOF_BUG and put the FOOF thing
 > into arch/i386/Config.in nicely with the other stuff

Agreed. This is what's done in 2.5 btw.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
