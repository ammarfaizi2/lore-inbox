Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSATRug>; Sun, 20 Jan 2002 12:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSATRu0>; Sun, 20 Jan 2002 12:50:26 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:21951 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S288854AbSATRuN>; Sun, 20 Jan 2002 12:50:13 -0500
Date: Sun, 20 Jan 2002 12:51:05 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4AD24D.4050206@namesys.com>
Message-ID: <Pine.LNX.4.33.0201201247270.6499-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Hans Reiser wrote:
> Write clustering is one thing it achieves.   When we flush a slum, the 

sure, that's fine.  when the VM tells you to write a page,
you're free to write *more*, but you certainly must give back
that particular page.  afaicr, this was the conclusion 
of the long-ago thread that you're referring to.

regards, mark hahn.

