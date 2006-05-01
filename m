Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWEAOMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWEAOMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWEAOMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:12:16 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44471 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932101AbWEAOMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:12:15 -0400
Subject: Re: [2.6 patch] fs/inotify.c: cleanups
From: Robert Love <rml@novell.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <john@johnmccutchan.com>,
       linux-kernel@vger.kernel.org, rml@ximian.com
In-Reply-To: <20060501071138.GJ3570@stusta.de>
References: <20060501071138.GJ3570@stusta.de>
Content-Type: text/plain
Date: Mon, 01 May 2006 10:12:20 -0400
Message-Id: <1146492740.7602.0.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 09:11 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make the following needlessly global variables static:
>   - inotify_max_user_instances
>   - inotify_max_user_watches
>   - inotify_max_queued_events
> - remove the following unused EXPORT_SYMBOL_GPL's:
>   - inotify_get_cookie
>   - inotify_unmount_inodes
>   - inotify_inode_is_dead
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: John McCutchan <john@johnmccutchan.com>

Acked-by: Robert Love <rml@novell.com>

	Robert Love


