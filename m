Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132965AbRAVS3a>; Mon, 22 Jan 2001 13:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132864AbRAVS3U>; Mon, 22 Jan 2001 13:29:20 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:48106 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132777AbRAVS3J>; Mon, 22 Jan 2001 13:29:09 -0500
Date: Mon, 22 Jan 2001 10:27:58 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Val Henson <vhenson@esscom.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010122111344.A17540@esscom.com>
Message-ID: <Pine.LNX.4.31.0101221026210.29530-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Val Henson wrote:

> There is a use for an optimized socket->socket transfer - proxying
> high speed TCP connections.  It would be exciting if the zerocopy
> networking framework led to a decent socket->socket transfer.

if you are proxying connextions you should really be looking at what data
you pass through your proxy.

now replay proxying with routing and I would agree with you (but I'll bet
this is handled in the kernel IP stack anyway)

David Lang

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
