Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUBREWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBREWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:22:54 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:27298 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263568AbUBREUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:20:13 -0500
Date: Wed, 18 Feb 2004 04:17:34 +0000
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040218041734.GK6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	sensors@stimpy.netroedge.com
References: <20040218031544.GB26304@redhat.com> <20040218040153.GB6729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218040153.GB6729@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:01:54PM -0800, Greg KH wrote:

 > Oh nevermind, that's just a dumb driver.  It's doing a release_region on
 > memory it didn't get.  Stupid, stupid, stupid...
 > 
 > Dave can you verify that this patch fixes the problem for you?

yep, 1 rmmod bug down, 16 billion to go.

thanks for fixing this up.

		Dave

