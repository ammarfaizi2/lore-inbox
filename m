Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130486AbQKGA3Q>; Mon, 6 Nov 2000 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbQKGA3G>; Mon, 6 Nov 2000 19:29:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15621 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130486AbQKGA25>; Mon, 6 Nov 2000 19:28:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: xterm: no available ptys
Date: 6 Nov 2000 16:28:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u7ibn$g5e$1@cesium.transmeta.com>
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com> <Pine.LNX.4.21.0011070157010.30406-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011070157010.30406-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
> 
> I'm missing ptmx. You NEED a writable /dev/pts dir.
> 

Actually, what you need is the devpts filesystem mounted onto
/dev/pts.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
