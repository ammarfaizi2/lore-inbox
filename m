Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVIDGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVIDGLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIDGLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 02:11:09 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:37476 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1751233AbVIDGLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 02:11:08 -0400
Date: Sat, 3 Sep 2005 23:10:45 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@istop.com>, Joel.Becker@oracle.com,
       linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904061045.GI21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903214653.1b8a8cb7.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:46:53PM -0700, Andrew Morton wrote:
> Actually I think it's rather sick.  Taking O_NONBLOCK and making it a
> lock-manager trylock because they're kinda-sorta-similar-sounding?  Spare
> me.  O_NONBLOCK means "open this file in nonblocking mode", not "attempt to
> acquire a clustered filesystem lock".  Not even close.
What would be an acceptable replacement? I admit that O_NONBLOCK -> trylock
is a bit unfortunate, but really it just needs a bit to express that -
nobody over here cares what it's called.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

