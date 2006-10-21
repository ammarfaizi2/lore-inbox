Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992907AbWJUJoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992907AbWJUJoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 05:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWJUJoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 05:44:25 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39569 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030385AbWJUJoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 05:44:24 -0400
Message-ID: <4539EBF3.8050607@drzeus.cx>
Date: Sat, 21 Oct 2006 11:44:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <45386E0E.7030404@drzeus.cx> <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 20 Oct 2006, Pierre Ossman wrote:
>   
>> I'm still learning the more fancy parts of git, but I think that would be:
>>
>> git diff master..for-linus | diffstat
>>     
>
> Use "git diff -M --stat master..for-linus" instead.
>
> The "-M" enables rename detection, and the "--stat" does the diffstat for 
> you (and better than plain diffstat, since it knows about renames, copies 
> and deletes).
>
> HOWEVER! The above obviously only really works correctly if "master" is a 
> strict subset of "for-linus".
>
>   

Ah, that's a bit of a gotcha. Any nice tricks to keep track of where you
where in sync with upstream last? Create a dummy branch/tag perhaps?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

