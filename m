Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264203AbRFHVBk>; Fri, 8 Jun 2001 17:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264230AbRFHVBa>; Fri, 8 Jun 2001 17:01:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53512 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264203AbRFHVBT>; Fri, 8 Jun 2001 17:01:19 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] 32-bit dma memory zone
Date: 8 Jun 2001 14:00:54 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9free6$lk4$1@cesium.transmeta.com>
In-Reply-To: <20010607153119.H1522@suse.de> <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com> <20010607145912.B2286@redhat.com> <m13d9b3ttj.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m13d9b3ttj.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> The AMD760 which looks like it might walk on both the alpha, an x86
> side of the fence also has an iommu.  Mostly it's used for AGP but
> according to the docs it should be able to handle the other cases as
> well.  The only downside is that it only supports 4GB of ram...
> 
> Anyway we shouldn't assume iommu's don't exist on x86.
> 

On most chips the AGP GART isn't just limited to AGP; it's a
full-fledged iommu.  The main problem with it is that it is usually a
rather limited space it provides.

       -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
