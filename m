Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319583AbSH3PH3>; Fri, 30 Aug 2002 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319588AbSH3PH2>; Fri, 30 Aug 2002 11:07:28 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:60399
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319583AbSH3PH2>; Fri, 30 Aug 2002 11:07:28 -0400
Subject: Re: Compile error with SiS support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Simon <ciccio@kiosknet.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020830115421.67aaccc7.ciccio@kiosknet.com.br>
References: <20020830115421.67aaccc7.ciccio@kiosknet.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 16:11:32 +0100
Message-Id: <1030720292.3196.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 15:54, Christoph Simon wrote:
> Hi!
> 
> I just tried to compile the kernel 2.4.19 with support for a SiS
> graphics card. The related options in .config I've set are:

You need SIS frame buffer support to use SIS DRM

In theory its possible to split the sis fb driver up but that hasnt been
attempted yet.

