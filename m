Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264143AbRFFUrw>; Wed, 6 Jun 2001 16:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264142AbRFFUrm>; Wed, 6 Jun 2001 16:47:42 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:63760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264141AbRFFUr1>; Wed, 6 Jun 2001 16:47:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: temperature standard - global config option?
Date: 6 Jun 2001 13:47:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fm4sc$ggd$1@cesium.transmeta.com>
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr> <Pine.LNX.4.33.0106061814470.1655-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0106061814470.1655-100000@cheetah.psv.nu>
By author:    Peter Svensson <petersv@psv.nu>
In newsgroup: linux.dev.kernel
> 
> Kelvin (decikelvin?) is probably a good unit to use in the kernel. If you
> want something else you convert it in the programs you use to interact
> with the kernel. This is a usespace issue, I think.
> 

Decikelvins is a good bet if we feel that fitting into 16 bits is a
necessary, or the width of things is limited.  Otherwise I would go
for millikelvins on the general principle that creating interfaces too
narrow is really painful.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
