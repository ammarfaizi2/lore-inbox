Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSGXLyf>; Wed, 24 Jul 2002 07:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSGXLyf>; Wed, 24 Jul 2002 07:54:35 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26870 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316997AbSGXLye>; Wed, 24 Jul 2002 07:54:34 -0400
Subject: Re: Errors in 2.4.19-rc3 CML rules (SiS related)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Scott Bronson <bronson@rinspin.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <34634.68.6.112.98.1027506178.squirrel@www.rinspin.com>
References: <34634.68.6.112.98.1027506178.squirrel@www.rinspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Jul 2002 14:11:19 +0100
Message-Id: <1027516279.6456.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 11:22, Scott Bronson wrote:
>   1) CONFIG_DRM_SIS needs to require CONFIG_FB_SIS_315.
>       Currently, you can select CONFIG_DRM_SIS without CONFIG_FB_SIS_315.
>       If you do that, you get undefined symbol errors for sis_malloc and
>          sis_free.
> 
>   2) CONFIG_FB_SIS must be compiled into the kernel (i.e. NOT a module).
>       Currently, you can compile it as a module.
>       If you do that, you ALSO get undefined symbol errors for
>          sis_malloc and sis_free.
> 
> These requirements could be enforced with CML rules.  Before I
> submit the patch to do this, I'd like to know if that's the proper
> fix!  Would it be better to just make CONFIG_FB_SIS able to be built
> as a module instead?

For the rules - go for it. For the modular driver ping the sisfb
maintainer first and check what is in the pipeline.

Alan

