Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVHUVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVHUVeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVHUVeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:34:36 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:30668 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751129AbVHUVeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:34:36 -0400
Date: Sun, 21 Aug 2005 20:32:42 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Sam Ravnborg <sam@ravnborg.org>,
       Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Message-ID: <20050821183242.GA18020@localhost.localdomain>
References: <20050819213447.GA9538@localhost.localdomain> <84144f02050819144660238be4@mail.gmail.com> <20050819232340.GB9538@localhost.localdomain> <20050820074106.GA15162@mars.ravnborg.org> <20050820091941.GA15936@localhost.localdomain> <20050820173706.GA11079@mars.ravnborg.org> <20050821151231.GE9530@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050821151231.GE9530@admingilde.org>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090201.4308C614.0006-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=D4?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sat, Aug 20, 2005 at 07:37:06PM +0200, Sam Ravnborg wrote:
> > > In make_docs.log.tar.bz2, you can find log files from make htmldocs,
> > > make psdocs and make pdfdocs.
> > 
> > From your log-files I could not see what went wrong. It seems to be
> > error in the generated files.
> 
> kerneldoc could not understand a macro definition.
> 
> please try
> http://tali.admingilde.org/patches/linux-docbook/docbook-fixes.patch
Martin, your patch works for the htmldocs target, but not for the
pdfdocs, I think there is a bug in a latex package. I don't know which
one, but it's the same error.

Thanks for your patch, 

Stephane

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


