Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129521AbQKVQ1T>; Wed, 22 Nov 2000 11:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130355AbQKVQ1J>; Wed, 22 Nov 2000 11:27:09 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:38213 "EHLO
        amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
        id <S129521AbQKVQ04>; Wed, 22 Nov 2000 11:26:56 -0500
Date: Wed, 22 Nov 2000 18:04:34 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Pauline Middelink <middelink@polyware.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
In-Reply-To: <20001122164842.A3420@polyware.nl>
Message-ID: <Pine.LNX.4.21.0011221803520.27178-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > #define __bad_udelay() panic("Udelay called with too large a constant")

Can't we change that to :
#error "Udelay..."


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
