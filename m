Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266300AbRGBA1v>; Sun, 1 Jul 2001 20:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266301AbRGBA1l>; Sun, 1 Jul 2001 20:27:41 -0400
Received: from imladris.infradead.org ([194.205.184.45]:25874 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S266300AbRGBA1b>;
	Sun, 1 Jul 2001 20:27:31 -0400
Date: Mon, 2 Jul 2001 01:27:27 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal
 11]
In-Reply-To: <3B3FBE8C.80803@zytor.com>
Message-ID: <Pine.LNX.4.33.0107020122350.18977-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

 >>>> Wasn't 2.2.12 the kernel that included the `lock halt` bug patch?

 >>> Perhaps, but is has absolutely nothing to do with the rest of
 >>> this discussion.

 >> The `lock halt` bug patch was specific to the Cyrix processors
 >> (not to be confused with the `lock registers` patch for the
 >> Intel processors, and I noted that the processor in question was
 >> a Cyrix one, hence the comment.

 > Oh.  Sorry, I don't know about "lock halt" and its effects.
 > However, if it refers to the instruction sequence LOCK HLT I
 > find it hard to believe it would have the symptoms described.

I don't have the paperwork to hand, and my memory isn't brilliant, but
the bug was something along the lines of Cyrix processors trashing the
SP if the instruction preceding (or following, I'm not sure which) a
HLT opcode was locked, and the patch was to remove some instances in
the kernel source where that occurred.

It's quite possibly unrelated, but...

Best wishes from Riley.

