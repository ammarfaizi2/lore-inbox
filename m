Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKSScR>; Sun, 19 Nov 2000 13:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSScI>; Sun, 19 Nov 2000 13:32:08 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:6652 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129472AbQKSScD>; Sun, 19 Nov 2000 13:32:03 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Ford <david@linux.com>, Gianluca Anzolin <g.anzolin@inwind.it>
Subject: Re: XMMS not working on 2.4.0-test11-pre7
Date: Sun, 19 Nov 2000 18:01:02 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001119150645.A732@fourier.home.intranet> <3A17FFDD.4532574B@linux.com>
In-Reply-To: <3A17FFDD.4532574B@linux.com>
MIME-Version: 1.0
Message-Id: <00111918015000.21052@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, David Ford wrote:
> 
> My guess is that it's a plugin, the source for xmms doesn't have "cpuinfo" anywhere in it.
> 
> -d
> 
> Gianluca Anzolin wrote:
> 
> > it seems there has been a change in the format of the /proc/cpuinfo file: infact 'flags: ' became 'features: '
> >
> > This change broke xmms and could broke any other program which relies on /proc/cpuinfo...
> >
> > I hope the problem will be solved (in the kernel or in every other program which uses /proc/cpuinfo) soon...

Are you using the 3Dnow input MP3 decoder plugin? This certainly attempts to
identify the CPU, so it can determine which decoder to use.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
