Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSAZDOv>; Fri, 25 Jan 2002 22:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289003AbSAZDOl>; Fri, 25 Jan 2002 22:14:41 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25607 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S289004AbSAZDOX>; Fri, 25 Jan 2002 22:14:23 -0500
Date: Sat, 26 Jan 2002 03:17:33 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add BUG_ON to 2.4 #1
Message-ID: <20020126031732.GA59924@compsoc.man.ac.uk>
In-Reply-To: <1012000446.3799.77.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012000446.3799.77.camel@phantasy>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 06:14:05PM -0500, Robert Love wrote:

> The following patch adds the BUG_ON (as seen on TV and 2.5) define to
> the 2.4 kernel.  This will help in portability and back-porting from 2.5
> to 2.4, plus BUG_ON is a nice optimization and aids readability.

I mentioned earlier today we need someone to step up and write a kcompat.h
for 2.5 stuff like minor() and the new remap_page_range().

I'll have to do this anyway for the stuff I use (I already have oodles of
2.2 stuff) but it would be nice to be able to use a "standard" header (and .c
if necessary)

regards
john
-- 
"ALL television is children's television."
	- Richard Adler 
