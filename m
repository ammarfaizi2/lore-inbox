Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267706AbUGWNPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267706AbUGWNPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 09:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267707AbUGWNPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 09:15:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:10835 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267706AbUGWNPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 09:15:42 -0400
Date: Fri, 23 Jul 2004 17:16:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Move modpost files to a new subdir [1/2]
Message-ID: <20040723151630.GA6914@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <40FFB68D.1000106@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFB68D.1000106@quark.didntduck.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 08:43:57AM -0400, Brian Gerst wrote:
> This patch simply moves modpost-related files to a seperate subdirectory.

I did this in my local tree but decided for a different directory name.
Usage of modpost would conflict with the modpost binary and I suspected
that some systems would not allow this clash.
I do not expect people to run make mrproper before applying a patch..

The new directory name is: scripts/mod - also signalling that this can be
used for other module related utilities in the future.

	Sam
