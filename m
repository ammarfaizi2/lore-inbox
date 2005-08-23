Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVHWTNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVHWTNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVHWTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:13:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1810 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932329AbVHWTNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:13:06 -0400
Date: Tue, 23 Aug 2005 21:12:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
Message-ID: <20050823191254.GB10110@alpha.home.local>
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B01FB.2070903@davyandbeth.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2005 at 06:01:15AM -0500, Davy Durham wrote:
> I just mean that when  I debug and catch the segv, it's dies because 
> some pointers now have corrupted values.  (usually because something is 
> overwriting some memory some where)
> 
> I'm currently re-writing some code to make it use select() instead of 
> epoll_wait() and see if everything is suddently fixed.  If so, then I 
> will suspect that epoll has a problem.  But it's still not ruled out 
> being my fault since it could be a timing issue that makes the crash 
> show up.

Just out of curiosity, have you had the opportunity to read some other
code which uses epoll ? Maybe reading others code could enlighten you
on potential bugs in your code, potential races, etc...

Regards,
Willy

