Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbTHFSEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTHFSEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:04:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10502
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270813AbTHFSE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:04:29 -0400
Date: Wed, 6 Aug 2003 11:04:27 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-ID: <20030806180427.GC21290@matchmail.com>
Mail-Followup-To: Diego Calleja Garc?a <diegocg@teleline.es>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org> <3F310B6D.6010608@namesys.com> <20030806183410.49edfa89.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806183410.49edfa89.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 06:34:10PM +0200, Diego Calleja Garc?a wrote:
> El Wed, 06 Aug 2003 18:06:37 +0400 Hans Reiser <reiser@namesys.com> escribi?:
> 
> > I don't think ext2 is a serious option for servers of the sort that 
> > Linux specializes in, which is probably why he didn't measure it.
> 
> Why?

Because if you have a power outage, or a crash, you have to run the
filesystem check tools on it or risk damaging it further.

Journaled filesystems have a much smaller chance of having problems after a
crash.
