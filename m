Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVESGyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVESGyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVESGyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:54:32 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:25898 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262404AbVESGy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:54:27 -0400
Date: Wed, 18 May 2005 23:54:05 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050519065405.GI1340@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <200505190230.23624.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505190230.23624.phillips@istop.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 02:30:23AM -0400, Daniel Phillips wrote:
> Zero terminated strings for lock names is bad taste.  It generates a bunch of 
> useless strlen executions and you force an ascii namespace for no apparent 
> reason.  Add a 9th parameter, namelen, to the lock call maybe?
Or perhaps pass in a qstr? Anyway I have to agree. That shouldn't be
difficult to fix up.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

