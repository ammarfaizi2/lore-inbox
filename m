Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319002AbSHST5e>; Mon, 19 Aug 2002 15:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319007AbSHST5d>; Mon, 19 Aug 2002 15:57:33 -0400
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:27012 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319002AbSHST5d>;
	Mon, 19 Aug 2002 15:57:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mel <mel@csn.ul.ie>, Scott Kaplan <sfkaplan@cs.amherst.edu>
Subject: Re: [PATCH] rmap 14
Date: Mon, 19 Aug 2002 21:50:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Bill Huey <billh@gnuppy.monkey.org>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <Pine.LNX.4.44.0208162247590.874-100000@skynet>
In-Reply-To: <Pine.LNX.4.44.0208162247590.874-100000@skynet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gsXp-0000rJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 August 2002 01:02, Mel wrote:
> On Fri, 16 Aug 2002, Scott Kaplan wrote:
> The measure is the time when the script asked the module to read a page.
> The page is read by echoing to a mapanon_read proc entry. It's looking
> like it takes about 350 microseconds to enter the module and perform the
> read. I don't call schedule although it is possible I get scheduled. The only
> way to be sure would be to collect all timing information within the module
> which is perfectly possible. The only trouble is that if the module collects,
> only one test instance can run at a time.

It sounds like you want to try the linux trace toolkit:

   http://www.opersys.com/LTT/

-- 
Daniel
