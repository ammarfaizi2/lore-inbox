Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbRAZPbJ>; Fri, 26 Jan 2001 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131774AbRAZPa7>; Fri, 26 Jan 2001 10:30:59 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:43654 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S131692AbRAZPat>;
	Fri, 26 Jan 2001 10:30:49 -0500
Date: Fri, 26 Jan 2001 15:29:51 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:  hotmail not dealing with ECN
In-Reply-To: <20010126161338.N3849@marowsky-bree.de>
Message-ID: <Pine.SOL.4.21.0101261528190.16539-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Lars Marowsky-Bree wrote:

> On 2001-01-26T15:08:21,
>    James Sutherland <jas88@cam.ac.uk> said:
> 
> > Obviously. The connection is now dead. However, trying to make a new
> > connection with different settings is perfectly reasonable.
> 
> No.
> 
> If connect() suddenly did two connection attempts instead of one, just how
> many timeouts might that break?

None. You time the request out as normal, if it does time out.

> > Why? The connection is dead, but there is nothing to prevent attempting
> > another connection.
> 
> Right. And thats why connect() returns an error and retries are handled in
> userspace.

Except you can't retry without ECN, because DaveM wants to do a Microsoft
and force ECN on everyone, whether they like it or not. If ECN is so
wonderful, why doesn't anybody actually WANT to use it anyway?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
