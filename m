Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUAFDwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUAFDwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:52:09 -0500
Received: from c-24-15-219-142.client.comcast.net ([24.15.219.142]:32952 "EHLO
	rekl.yi.org") by vger.kernel.org with ESMTP id S265329AbUAFDwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:52:06 -0500
Date: Mon, 5 Jan 2004 21:52:04 -0600 (CST)
From: lk@rekl.yi.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: KM266/VT8235, USB2.0 and problems
In-Reply-To: <20040105172306.GB21531@kroah.com>
Message-ID: <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
References: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org>
 <20040105081226.GA14177@kroah.com> <Pine.LNX.4.58.0401051045270.30821@rekl.yi.org>
 <20040105172306.GB21531@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Do the errors go away if you stop using devfs?
> > 

Ok, I removed devfs support from the kernel, and installed udev on the 
machine.  I get the same error:

SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 7552
Buffer I/O error on device sda, logical block 944



I migrated my laptop to use udev, also.  The USB stick still works 
perfectly on it.

Any other suggestions?

