Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131373AbRAZPJO>; Fri, 26 Jan 2001 10:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRAZPJF>; Fri, 26 Jan 2001 10:09:05 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:38528 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S131858AbRAZPIt>;
	Fri, 26 Jan 2001 10:08:49 -0500
Date: Fri, 26 Jan 2001 15:08:21 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <14961.33191.626833.945221@pizda.ninka.net>
Message-ID: <Pine.SOL.4.21.0101261506240.16539-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, David S. Miller wrote:
> James Sutherland writes:
>  > I was not suggesting ignoring these. OTOH, there is no reason to treat an
>  > RST packet as "go away and never ever send traffic to this host again" -
>  > i.e. trying another TCP connection, this time with ECN disabled, would be
>  > acceptable.
> 
> The connection failed, RST means connection reset.  RST means all
> state is corrupt and this connection must die.  It cannot be
> interpreted in any other way.

Obviously. The connection is now dead. However, trying to make a new
connection with different settings is perfectly reasonable.

> Using it as a metric for ECN enabling is thus unacceptable.

Why? The connection is dead, but there is nothing to prevent attempting
another connection.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
