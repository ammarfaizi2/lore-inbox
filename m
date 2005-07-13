Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVGMVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVGMVfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVGMVeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:34:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262351AbVGMVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:31:13 -0400
Date: Wed, 13 Jul 2005 14:31:07 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: usb mass storage bug
Message-Id: <20050713143107.5af22149.zaitcev@redhat.com>
In-Reply-To: <20050713205316.GA16238@kroah.com>
References: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com>
	<mailman.1121138161.21500.linux-kernel2news@redhat.com>
	<20050712225013.2e66d0fc.zaitcev@redhat.com>
	<20050713205316.GA16238@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005 13:53:16 -0700, Greg KH <greg@kroah.com> wrote:

> You are right, ub isn't _that_ slow at all, I use it all the time on
> some of my devices just fine.

Ub actually gets terribly slow when partition size is odd (for both
reading and writing). I even have a patch for it, but it's yucky.
Here's the original discussion:
 http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/f11b7721d7ed6d1f&hl=en

-- Pete
