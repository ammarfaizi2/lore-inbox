Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTGCOLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTGCOLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:11:41 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45956 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S263275AbTGCOLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:11:39 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Thu, 3 Jul 2003 16:27:11 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
References: <200307021823.56904.kernel@kolivas.org> <200307031346.04354.phillips@arcor.de> <200307032221.55773.kernel@kolivas.org>
In-Reply-To: <200307032221.55773.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307031627.11299.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 14:21, Con Kolivas wrote:
> Theory? uh erm it's rather involved but basically instead
> of working off the accumulated sleeping ticks gathered in ten seconds it
> works on the accumulated sleeping ticks gathered till it wakes up. It has
> non linear semantics to cope with the fact that you cant accumulate 10
> seconds worth of ticks (for example) if only 10 seconds has passed
> (likewise for less time). Also idle tasks are no longer considered fully
> interactive but idle and receive no boost or penalty. Finally they all
> start with some sleep ticks inherited by their parent as though they have
> been running for 1 second at least.

I'm still pretty much in the dark after that.  It says something about your 
patch, but it doesn't say much about the problem you're solving, i.e., what's 
the Context?  (pun intended)

Regards,

Daniel

