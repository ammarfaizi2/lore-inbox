Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVBBV4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVBBV4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVBBVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:49:48 -0500
Received: from adsl-195-86.38-151.net24.it ([151.38.86.195]:53261 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262810AbVBBVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:48:09 -0500
In-Reply-To: <20050202155403.GE3117@crusoe.alcove-fr>
References: <20050202155403.GE3117@crusoe.alcove-fr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <51cfdfdc084037ae1e3f164b0c524abc@libero.it>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniele Venzano <webvenza@libero.it>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Date: Wed, 2 Feb 2005 22:47:58 +0100
To: Stelian Pop <stelian@popies.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno 02/feb/05, alle 16:54, Stelian Pop ha scritto:

> Hi,
>
> I've played lately a bit with Subversion and used it for managing
> the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
> bkcvs2svn conversion script.

Really useful, thanks !
I'm using svn to manage a very small part of the kernel tree (2 files). 
It is difficult to keep in sync with mainstream development without 
having to fetch and keep huge amounts of data (this regardless of the 
version control system used).

For now I'm keeping the latest stable 2.6 release of the files I need 
in the svn repo, then when I need to sync with the rest of the world, I 
get the latest -bk patch and see if there are some related changes. If 
so, I create a new branch, apply the -bk patch (only the interesting 
part) and then apply my modifications on top of that.

That still means I have to download usually a >1MB compressed file for 
~60KB of interesting (uncompressed) data, but that is still much better 
than the gigabytes of network traffic needed for a full kernel tree and 
up to date working copies.

Thanks, bye.
--
Daniele Vezano
http://teg.homeunix.org

