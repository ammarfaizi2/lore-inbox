Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVENSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVENSrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 14:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVENSrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 14:47:24 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:56011 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261457AbVENSrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 14:47:22 -0400
Date: Sat, 14 May 2005 11:47:11 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gregory Brauer <greg@wildbrain.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <20050514184711.GA27565@taniwha.stupidest.org>
References: <428511F8.6020303@wildbrain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428511F8.6020303@wildbrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 01:45:44PM -0700, Gregory Brauer wrote:

> I have seen some references to a similar bug in other kernel list
> posts from October 2004 and am trying to figure out if this is the
> same problem, or something new related to the xfs_iget_core patch in
> 2.6.11.  This seems to be a very hard to reproduce bug, but we've
> seen this problem twice in a week of testing under Fedora
> Core 3 on the following kernel:

does disabling CONFIG_4K_STACKS help?
