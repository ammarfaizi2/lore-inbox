Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282893AbRLQViB>; Mon, 17 Dec 2001 16:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282898AbRLQVhv>; Mon, 17 Dec 2001 16:37:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282893AbRLQVhs>; Mon, 17 Dec 2001 16:37:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ia64 unaligned accesses in ntfs driver
Date: 17 Dec 2001 13:37:42 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vloj6$8ff$1@cesium.transmeta.com>
In-Reply-To: <20011216191325.K12063@niksula.cs.hut.fi> <20011216124328.E21566@niksula.cs.hut.fi> <20011216191325.K12063@niksula.cs.hut.fi> <5.1.0.14.2.20011217093040.0319a310@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5.1.0.14.2.20011217093040.0319a310@pop.cus.cam.ac.uk>
By author:    Anton Altaparmakov <aia21@cam.ac.uk>
In newsgroup: linux.dev.kernel
> 
> They are at least one of the explanations why the driver would not work on 
> non-intel arch... I gather most other arch don't cope with unaligned 
> accesses. I am surprised those are the only ones you see actually...
> 

A lot of arch's that don't do, however, support emulating it via a
trap handler.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
