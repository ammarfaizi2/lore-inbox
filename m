Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCaAJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCaAJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:09:45 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:42944 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262256AbUCaAJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:09:43 -0500
Message-ID: <406A0C15.7090506@pacbell.net>
Date: Tue, 30 Mar 2004 16:08:53 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       maneesh@in.ibm.com, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
References: <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:

> 	  I'm in favor of changing the behavior of sysfs, so that either it
> refuses to delete directories that contain subdirectories or else it
> recursively deletes the subdirectories first.  At this point nothing has
> been settled.

Hmm, certainly I agree khubd should be deleting things bottom-up.

Are you say it isn't doing that already?  Or that it's trying to,
but something's preventing that from working?

- Dave




