Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUJJAwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUJJAwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUJJAwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:52:18 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:63985 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267951AbUJJAwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:52:17 -0400
Message-ID: <9e47339104100917527993026d@mail.gmail.com>
Date: Sat, 9 Oct 2004 20:52:16 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [RFC] [patch] drm core internal versioning..
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0410100050160.6083@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410100050160.6083@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How strong of match requirement do we need? Note that this only
impacts distribution of binary personality modules, if you have source
there is no problem.

Several stronger solutions:
on each CVS check-in to DRM increment a count and use this for an id
manual version number for DRM
embed the kernel version
embed the kernel version plus distribution info


-- 
Jon Smirl
jonsmirl@gmail.com
