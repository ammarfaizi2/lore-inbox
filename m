Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUGUOmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUGUOmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUGUOl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:41:59 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:35479 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266349AbUGUOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:41:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
In-Reply-To: <20040721141524.GA12564@kroah.com>
References: <20040721141524.GA12564@kroah.com>
Message-Id: <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 21 Jul 2004 15:41:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:

>Ok, to test out the new development model, here's a nice patch that
>simply removes the devfs code.  No commercial distro supports this for
>2.6, and both Gentoo and Debian have full udev support for 2.6, so it is
>not needed there either.  Combine this with the fact that Richard has
>sent me a number of good udev patches to fix up some "emulate devfs with
>udev" minor issues, I think we can successfully do this now.

The new Debian installer requires devfs on several architectures, even
for 2.6 installs. That's unlikely to get changed before release.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
