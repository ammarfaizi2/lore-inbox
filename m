Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRKVRmH>; Thu, 22 Nov 2001 12:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRKVRl5>; Thu, 22 Nov 2001 12:41:57 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:18650 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280026AbRKVRlt>; Thu, 22 Nov 2001 12:41:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 17:41:48 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166wSm-00063a-00@mauve.csi.cam.ac.uk> <3BFD2997.95F2B9EE@starband.net>
In-Reply-To: <3BFD2997.95F2B9EE@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166xr9-0000Qy-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 4:36 pm, war wrote:
> The bottom line here is:
>
> There is no need for swap if you have enough ram.
> Using swap with more than enough ram does absolutley nothing for the
> system, except by degrading the performance of it.

If the system has so much RAM that EVERYTHING fits in RAM - programs, data 
and FS cache - then the swap won't be touched anyway, and makes no 
difference. This is rather unlikely on a PC; in practice, adding swap should 
always improve matters. (Of course, the VM isn't perfect yet...)


James.
