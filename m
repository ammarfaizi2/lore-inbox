Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSEBUkU>; Thu, 2 May 2002 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315412AbSEBUkT>; Thu, 2 May 2002 16:40:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13574 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315413AbSEBUkS>; Thu, 2 May 2002 16:40:18 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot protocol 2.04 9/11
Date: 2 May 2002 13:39:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aas85i$qpq$1@cesium.transmeta.com>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <m1adriy4im.fsf_-_@frodo.biederman.org> <m16626y4et.fsf_-_@frodo.biederman.org> <m11ycuy48d.fsf_-_@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m11ycuy48d.fsf_-_@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> +0200/2  2.00+  jump                  Jump instruction

I would like to make it an explicit part of the protocol that the jump
instruction must jump to the first byte following the header.  It can
therefore be used to determine the end of the header.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
