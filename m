Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBDGdE>; Sun, 4 Feb 2001 01:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRBDGcy>; Sun, 4 Feb 2001 01:32:54 -0500
Received: from www.wen-online.de ([212.223.88.39]:17936 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129261AbRBDGcl>;
	Sun, 4 Feb 2001 01:32:41 -0500
Date: Sun, 4 Feb 2001 07:32:34 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch?] RAMFS
In-Reply-To: <Pine.Linu.4.10.10102031945190.396-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10102040713280.663-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Mike Galbraith wrote:

> Hi,
> 
> With the patch below...

However, tmpfs appears to cover the functionality provided by ramfs.
Are there any uses for ramfs which can't be handled by tmpfs?

The only thing I could think of was "what if you don't have a
swap device up and running".  Seems it doesn't need one :))

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
