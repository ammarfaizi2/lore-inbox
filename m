Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTLNXRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTLNXRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:17:18 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:36785
	"EHLO bastard") by vger.kernel.org with ESMTP id S262782AbTLNXRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:17:10 -0500
Message-ID: <3FDCEF70.5040808@tupshin.com>
Date: Sun, 14 Dec 2003 15:17:04 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper
References: <20031214172156.GA16554@work.bitmover.com>
In-Reply-To: <20031214172156.GA16554@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>Merry Christmas.
>
>I've prototyped an extension to BitKeeper that provides tarballs
>and patches.  The idea is to make it possible for all trees hosted by
>bkbits.net provide access to the data with a free client (included below
>in prototype form).
>
>The system is simplistic, it just provides a way to get the most recent
>sources as a tarball and then any later updates as a patch.  There is
>no provision for generating diffs, editing files, merging, etc.  All of
>that is something that you can write, if you want, using standard tools
>(think hard linked trees).
>
>Before rolling this out, I want to know if this is going to (finally)
>put to rest any complaints about BK not being open source, available on
>all platforms, etc.  You need to understand that this is all you get,
>we're not going to extend this so you can do anything but track the most
>recent sources accurately.  No diffs.  No getting anything but the most
>recent version.  No revision history.  
>
>If you want anything other than the most recent version your choices
>are to use BitKeeper itself or, if you want the main branches of the
>Linux kernel, the BK2CVS exports.  This is not a gateway product, it
>is a way for developers to track the latest and greatest with a free
>(source based) client.  It is not a way to convert BK repos to $SCM.
>
>If the overwhelming response is positive then I'll add this to the
>bkbits.net server and perhaps eventually to the BK product itself.
>
>--lm
>
I'm sure many people will find this useful. Personally (and this is not 
intended as any sort of flame bait), I just want a way to get access to 
all raw bk changesets for a given project. All existing methods of 
getting information out of a bk repository either involve running bk 
yourself, or getting incomplete information. You have argued 
(succesfully) that the CVS export doesn't lose very much information, 
but an argument can be made that any information loss is too much. After 
all, the information I am talking about is simply what was put into the 
system by the developers in the first place.

-Tupshin
