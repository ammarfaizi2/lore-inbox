Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUIOVgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUIOVgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:33:43 -0400
Received: from peabody.ximian.com ([130.57.169.10]:59843 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267545AbUIOV1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:27:31 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Tim Hockin <thockin@hockin.org>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915212322.GB25840@kroah.com>
References: <20040915034455.GB30747@kroah.com>
	 <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
	 <1095281358.23385.109.camel@betsy.boston.ximian.com>
	 <20040915205643.GA19875@hockin.org>  <20040915212322.GB25840@kroah.com>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:26:29 -0400
Message-Id: <1095283589.23385.117.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:23 -0700, Greg KH wrote:

> We aren't giving absolute /dev entries here, that's the beauty of the
> kobject tree :)

Not that I agree, but I don't think it is the absolute /dev entries that
bother him: it is the fact that knowledge of the mount itself is an
information leak.

Which it is.  As root, in my name space, I should rest in the knowledge
that my mounts are secret, I guess.  But I just do not see it as a big
problem.

	Robert Love


