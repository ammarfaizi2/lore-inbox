Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTLWTaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTLWT3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:29:53 -0500
Received: from peabody.ximian.com ([141.154.95.10]:52708 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262331AbTLWT3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:29:03 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223192427.GC4176@parcelfarce.linux.theplanet.co.uk>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com>
	 <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur>
	 <20031223192427.GC4176@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1072207737.6015.26.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 14:28:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 14:24, viro@parcelfarce.linux.theplanet.co.uk
wrote:

> Junk like that is called "sysctl" and is a part of userland ABI.

Right.  And I agree 100% that we need to respect that ABI.

Long-term, though, we need to think about a saner home for sysctl's than
procfs.  hch's suggestion of giving them their own filesystem is a good
idea to start with.

Right now, though, I think it is a shining exemplar of sanity to
associate device-related attributes with the device's directory in
sysfs.

	Rob Love


