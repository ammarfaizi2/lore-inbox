Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUEQTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUEQTti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEQTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:49:37 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54912
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262897AbUEQTtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:49:21 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>, Hugh Dickins <hugh@veritas.com>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Date: Wed, 12 May 2004 12:52:13 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
References: <20040506130846.GA241@elf.ucw.cz> <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain> <20040507165700.GE18175@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040507165700.GE18175@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121252.14006.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 May 2004 11:57, Pavel Machek wrote:
> Hi!
>
> > > Perhaps what we really want is "swap_back_in" script? That way you
> > > could do "updatedb; swap_back_in" in cron and be happy.
> >
> > swapoff -a; swapon -a
>
> Good point... it will not bring back executable pages, through.
>
> 								Pavel

What would the above do if there wasn't enough memory to swap everything back 
in?  (Presumably, the swapoff would fail?)

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)


