Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWEZORY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWEZORY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWEZORX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:17:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27538 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750771AbWEZORV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:17:21 -0400
Date: Fri, 26 May 2006 07:17:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Drynoff <pauldrynoff@gmail.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
In-Reply-To: <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605260714460.30772@schroedinger.engr.sgi.com>
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com> 
 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com> 
 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com> 
 <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI> 
 <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com> 
 <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com>
 <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Paul Drynoff wrote:

> Thanks everyone for comments.
> Here is new patch: it make possible creation of kmalloc(9)
> and kzalloc(9).

Documentation of in kernel functions in the manpages <boogle>. You are 
going to do this full time in order to keep all of it up to date?

In that case you should add something to install the manpages 
for each kernel when one does

make install_man

from the top of the kernel tree.
