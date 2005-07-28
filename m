Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVG1LL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVG1LL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVG1LL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:11:59 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:3335 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261372AbVG1LL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:11:58 -0400
To: sam@ravnborg.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050727191645.GA30081@mars.ravnborg.org> (message from Sam
	Ravnborg on Wed, 27 Jul 2005 21:16:45 +0200)
Subject: Re: 2.6.13-rc3-mm2 (kbuild broken for external modules)
References: <20050727024330.78ee32c2.akpm@osdl.org> <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu> <20050727191645.GA30081@mars.ravnborg.org>
Message-Id: <E1Dy6Ib-0002xN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Jul 2005 13:11:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the report. I had overlooked this usage when modifying this
> part of kbuild.
> The following fix it - and work in the following test setups:
> make
> make O=
> make M=
> make O= M=

Yes, it works now. 

Thanks,
Miklos
