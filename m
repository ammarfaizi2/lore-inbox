Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280161AbRKVRjh>; Thu, 22 Nov 2001 12:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRKVRj2>; Thu, 22 Nov 2001 12:39:28 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:38873 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280161AbRKVRjU>; Thu, 22 Nov 2001 12:39:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 17:39:19 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk> <3BFD2709.31A1A85E@starband.net>
In-Reply-To: <3BFD2709.31A1A85E@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166xok-0000Nm-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 4:25 pm, war wrote:
> Why have SWAP if you don't need it - answer that.?

Having it is supposed to improve performance. If you take two identical 
machines, and enable swap on one but not the other, the first machine should 
have better performance: it can cache the FS more effectively.

Now, if you have INSANE amounts of RAM (i.e. enough to have everything 
running in RAM *AND* every file you access cached) the swap will make no 
difference at all. Under any other circumstances, it should make things 
better.


James.
