Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSGXNTV>; Wed, 24 Jul 2002 09:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGXNTU>; Wed, 24 Jul 2002 09:19:20 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:64249 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317148AbSGXNTT>; Wed, 24 Jul 2002 09:19:19 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0207192019230.1639-100000@chaos.physics.uiowa.edu> 
References: <Pine.LNX.4.44.0207192019230.1639-100000@chaos.physics.uiowa.edu> 
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: John Levon <movement@marcelothewonderpenguin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jul 2002 14:21:59 +0100
Message-ID: <25869.1027516919@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kai@tp1.ruhr-uni-bochum.de said:
>  Basically, use only one Makefile and
> 	blah-objs := blah_init.o blahstuff/blah1.o blahstuff/blah2.o ... 

Er, don't the dependencies get screwed then, because it fails to create 
.blahstuff/blah1.o.flags, etc.?


--
dwmw2


