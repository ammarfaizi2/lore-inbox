Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbUDPXrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbUDPXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:47:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5257 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263989AbUDPXqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:46:04 -0400
Date: Sat, 17 Apr 2004 00:46:02 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416223732.GC21701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 03:37:32PM -0700, Greg KH wrote:

> Since when did we ever assume that renaming a kobject would rename the
> symlinks that might point to it?  Renaming kobjects are a hack that way,
> if you use them, you need to be aware of this limitation.

Since we assume that these symlinks actually reflect some relationship
between the objects and are really needed for something.  If they are
not - why the hell do we keep them at all?
