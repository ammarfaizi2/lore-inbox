Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSIZPAf>; Thu, 26 Sep 2002 11:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSIZPAf>; Thu, 26 Sep 2002 11:00:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:16889
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261349AbSIZPAe>; Thu, 26 Sep 2002 11:00:34 -0400
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 20020912161258.A9056@informatics.muni.cz
Cc: linux-kernel@vger.kernel.org, Mark Hahn <hahn@physics.mcmaster.ca>,
       kernel@street-vision.com, Petr Konecny <pekon@informatics.muni.cz>,
       "Bruno A. Crespo" <bruno@conectatv.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20020925132422.GC14381@fi.muni.cz>
References: <20020925132422.GC14381@fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:08:10 +0100
Message-Id: <1033052890.1269.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the obvious fix is to simply disable the APIC on all such
systems

