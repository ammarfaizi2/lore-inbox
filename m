Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRIFWjE>; Thu, 6 Sep 2001 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRIFWiy>; Thu, 6 Sep 2001 18:38:54 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:24229
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268813AbRIFWih>; Thu, 6 Sep 2001 18:38:37 -0400
Date: Thu, 06 Sep 2001 18:38:59 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>,
        Mack Stevenson <mackstevenson@hotmail.com>
cc: linux-kernel@vger.kernel.org, _deepfire@mail.ru,
        Edward Shushkin <edward@mail.infotel.ru>
Subject: Re: Basic reiserfs question
Message-ID: <895160000.999815938@tiny>
In-Reply-To: <3B97729B.1F49AACA@namesys.com>
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
 <3B97729B.1F49AACA@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 06, 2001 04:56:59 PM +0400 Hans Reiser
<reiser@namesys.com> wrote:

> It seems that we should put something in journal replay that says:
> 
> "Warning: replaying a non-empty journal, this means that either your
> system crashed, or its shutdown scripts need fixing (a common distro
> failing at the moment), or you pushed the power button.  Don't use the
> hardware power button to turn your computer off before telling the
> operating system software to halt (there exists a 'halt' command you can
> use), the risk in doing so is that the files you or your software were
> writing to at the time you pushed the button can have garbage added to
> them."
> 
> Chris, do you agree?  Edward, please make this change and create a patch.

Sorry, I'm a bit slow this week, I caught a cold at linux world (apparently
the users are contagious).

Anyway, the text above is great for a man page.  kernel messages don't take
more than one line ;-)

-chris


