Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbREUUVQ>; Mon, 21 May 2001 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbREUUVJ>; Mon, 21 May 2001 16:21:09 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:56580 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261684AbREUUU3>;
	Mon, 21 May 2001 16:20:29 -0400
Message-ID: <20010520235409.G2647@bug.ucw.cz>
Date: Sun, 20 May 2001 23:54:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105200957500.323-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva>; from Rik van Riel on Sun, May 20, 2001 at 05:49:09AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You're right.  It should never dump too much data at once.  OTOH, if
> > those cleaned pages are really old (front of reclaim list), there's no
> > value in keeping them either.  Maybe there should be a slow bleed for
> > mostly idle or lightly loaded conditions.
> 
> If you don't think it's worthwhile keeping the oldest pages
> in memory around, please hand me your excess DIMMS ;)

Sorry, Rik, you can't have that that DIMM. You know, you are
developing memory managment, and we can't have you having too much
memory available ;-).
								  Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
