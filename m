Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319217AbSH2OuJ>; Thu, 29 Aug 2002 10:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319218AbSH2OuI>; Thu, 29 Aug 2002 10:50:08 -0400
Received: from daimi.au.dk ([130.225.16.1]:29327 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S319217AbSH2OuI>;
	Thu, 29 Aug 2002 10:50:08 -0400
Message-ID: <3D6E35A0.F60239BE@daimi.au.dk>
Date: Thu, 29 Aug 2002 16:54:24 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: exporting symbols in kernel only when a module is compiled?
References: <1030552792.581.38.camel@zaphod>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> 
> So if one statically compiles in ipv6 or doesnt compile it at
> all, its not available to any other modules.

I think the major problem here is, that if you at first doesn't
compile ipv6 at all, and later want to compile it as a module,
it will not work. I think it would be better if choosing a
feature as module or not compiled at all doesn't change anything
in the kernel.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
