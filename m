Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272518AbRH3WK5>; Thu, 30 Aug 2001 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272519AbRH3WKr>; Thu, 30 Aug 2001 18:10:47 -0400
Received: from anime.net ([63.172.78.150]:22276 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S272518AbRH3WKg>;
	Thu, 30 Aug 2001 18:10:36 -0400
Date: Thu, 30 Aug 2001 15:10:37 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010830150444.C1451@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.30.0108301508490.7908-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Mike Fedyk wrote:
> Hmm.  Is there any chance of *not* replaying the log on mount-ro, and using
> a combination of on disk meta-data, and journal?

there is also the interesting problem of being unable to fsck xfs even
when its successfully mounted-ro and consistent. even when mounted ro, it
whinges that the fs is in use and refuses to fsck.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


