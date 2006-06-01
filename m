Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWFARrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWFARrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWFARrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:47:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:17508 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965205AbWFARrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:47:03 -0400
Message-ID: <acdcfe7e0606011046y727c3e5aob478a408e29c7a0f@mail.gmail.com>
Date: Thu, 1 Jun 2006 13:46:41 -0400
From: "Robert Love" <rlove@rlove.org>
To: "Amy Griffis" <amy.griffis@hp.com>
Subject: Re: [PATCH] inotify: split kernel API from userspace support
Cc: linux-kernel@vger.kernel.org, "John McCutchan" <john@johnmccutchan.com>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060601150702.GA2171@zk3.dec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601150702.GA2171@zk3.dec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Amy Griffis <amy.griffis@hp.com> wrote:

> The following series of patches introduces a kernel API for inotify,
> making it possible for kernel modules to benefit from inotify's
> mechanism for watching inodes.  With these patches, inotify will
> maintain for each caller a list of watches (via an embedded struct
> inotify_watch), where each inotify_watch is associated with a
> corresponding struct inode.  The caller registers an event handler and
> specifies for which filesystem events their event handler should be
> called per inotify_watch.

Thank you for breaking the patch up.  Looks good to me.

Acked-by: Robert Love <rml@novell.com>

        Robert Love
