Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269765AbTGKCUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 22:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269766AbTGKCUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 22:20:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57860 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S269765AbTGKCUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 22:20:21 -0400
Date: Thu, 10 Jul 2003 22:35:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Eli Carter <eli.carter@inet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
In-Reply-To: <3F0DD21B.5010408@inet.com>
Message-ID: <Pine.LNX.4.44L0.0307102233230.12370-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Eli Carter wrote:

> Alan Stern wrote:
> [snip]
> > Ultimately this comes down to a question of style and taste.  This 
> > particular issue is not addressed in Documentation/CodingStyle so I'm 
> > raising it here.  My personal preference is for code that means what it 
> > says; if a pointer is checked it should be because there is a genuine 
> > possibility that the pointer _is_ NULL.  I see no reason for pure 
> > paranoia, particularly if it's not commented as such.
> > 
> > Comments, anyone?
> 
> BUG_ON() perhaps?

Not really needed, since a segfault will produce almost as much 
information as a BUG_ON().  Certainly it will produce enough to let a 
developer know that the pointer was NULL.

Alan Stern> 

