Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUCORob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUCORob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:44:31 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:22341 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262632AbUCORoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:44:30 -0500
Date: Mon, 15 Mar 2004 18:45:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: dick morales <gelstat_mystery@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KBUILD, FEATURE]
Message-ID: <20040315174506.GB2163@mars.ravnborg.org>
Mail-Followup-To: dick morales <gelstat_mystery@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY14-F14t9NbbkFKJz0004f2ae@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY14-F14t9NbbkFKJz0004f2ae@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 04:49:57AM -0800, dick morales wrote:
> Hi all!
> 
> Many times i saw and did things like "time make bzImage modules" or "times 
> ..." to know
> how long kernel compile process takes, many users and admins use similar 
> technique.
> Is it possible to add this feature to genuine kernel?
> Like adding (in the top Makefile, kbuild hackers please help)
> START_TIME=`date +"%s"`
> END_TIME=`date +"%s"`
> _TIME=$(($END_TIME-$START_TIME))
> or in another form with days(anyone use 2.6 on 486 ;) ?), hours, min,sec.

I see no need to add this to kbuild when this is so easy to do.
Just use the above mentioned command.

	Sam

