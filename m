Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUG1TVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUG1TVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUG1TVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:21:34 -0400
Received: from main.gmane.org ([80.91.224.249]:6059 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262450AbUG1TVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:21:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tristan Wibberley <tristan@maihem.org>
Subject: Re: Interesting race condition...
Date: Wed, 28 Jul 2004 18:08:15 +0100
Message-ID: <pan.2004.07.28.17.08.14.967215@maihem.org>
References: <200407222204.46799.rob@landley.net> <20040728010546.3b7933d5.pj@sgi.com> <200407281142.37194.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host217-43-27-25.range217-43.btcentralplus.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 11:42:37 -0500, Rob Landley wrote:

> On Wednesday 28 July 2004 03:05, Paul Jackson wrote:
>> Rob wrote:
>> > I just saw a funky thing.  Here's the cut and past from the xterm...
>>
>> Can you reproduce this by cat'ing /proc/<pid>/cmdline?  Can you get a
>> dump of the proc cmdline file to leak the environment sometimes?
> 
> I saw it exactly once, I'm afraid.  Somebody else said they also saw it...  
> once.  It smelled to me like a race condition, with the process 
> starting/exiting right as ps looked at it, but I haven't seen it again.  (I 
> could run the command in a loop overnight...)

I think I have seen this exactly once. I ran helixplayer from a bash
command line and it quit, immediately spouting something about how it
couldn't find a file whose name looked remarkably similar to
some environment variables. I had put it down to screwed terminal settings
so I couldn't see I had pasted something in, and I immediately issued a
reset, so I have no more information I'm afraid.

-- 
I have a little sig...


