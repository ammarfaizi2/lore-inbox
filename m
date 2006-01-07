Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWAGVli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWAGVli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWAGVli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:41:38 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:4496 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030593AbWAGVlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:41:37 -0500
Date: Sat, 7 Jan 2006 13:38:21 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kurt.hackel@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] OCFS2: __init / __exit problem
Message-ID: <20060107213821.GD3313@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060107132008.GE820@lug-owl.de> <20060107190702.GT3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107190702.GT3774@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 08:07:02PM +0100, Adrian Bunk wrote:
> It's a real problem that due to the fact that these errors have become 
> runtime errors on i386 in kernel 2.6, we do no longer have a big testing 
> coverage for them.  :-(
Indeed. Those function declarations have been in there for a while,
without any issue until now. Thanks for the patch Adrian.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

