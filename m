Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTENX74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTENX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:59:56 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:30427 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263185AbTENX7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:59:55 -0400
Date: Thu, 15 May 2003 02:10:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030515001048.GA14685@elf.ucw.cz>
References: <20030514224212.GA8124@elf.ucw.cz> <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > appears the flashing is the issue. I will see if a hardware cursor
> > > also has
> 
>    Your right. I realize my logic error. I was literally thinking too black 
> and white. In the case of a cursor that is a white thin line at the bottom 
> and a grey background. That is whole cursor image!! The mask should be
> the font image to be drawn. 
>    You can think of it as the cursor being a big grey cookie with white 
> frosting decoration on the bottom. Then I come with my font shape cookie 
> cutter and cut it out.  

I'm not sure I follow you.

What I do in that echo is set softcursor. It was software cursor even
on plain vga. Boot into 2.4 to see how it should look like. It works
even in vga text modes. It is different from softcursor later
introduced by fbcon. Documentation/VGA-softcursor.txt describes it.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
