Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUIEF5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUIEF5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 01:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUIEF5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 01:57:20 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:41083 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266216AbUIEF5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 01:57:18 -0400
Date: Sun, 5 Sep 2004 08:00:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK pull] DRM macro removal part 2
Message-ID: <20040905060010.GA8295@mars.ravnborg.org>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409050203270.29736@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409050203270.29736@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave

On Sun, Sep 05, 2004 at 02:05:12AM +0100, Dave Airlie wrote:
> 
> <airlied@starflyer.(none)> (04/09/05 1.2022)
>    remove DRIVER_FILE_FIELDS, replace with a private driver structure
>    allocated in open helper and freed in free_filp_priv.
> 
>    Signed-off-by: Dave Airlie <airlied@linux.ie>


If you make your changelog look like (no '-'es):
-------------------------------------------------------------------
drm: remove DRIVER_FILE_FIELDS
<empty line>
remove DRIVER_FILE_FIELDS, replace with a private driver structure
allocated in open helper and freed in free_filp_priv.

Signed-off-by: Dave Airlie <airlied@linux.ie>
-------------------------------------------------------------------

Then it will look nice in the short changelog Linus post for each
-rc, final release.
And the drm: tag is a way to tell non-insiders that this patch
changes drm.

	Sam
