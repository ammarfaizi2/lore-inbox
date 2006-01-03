Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWACUoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWACUoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWACUoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:44:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932403AbWACUod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:44:33 -0500
Date: Tue, 3 Jan 2006 12:44:04 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dtor_core@ameritech.net, dmitry.torokhov@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: usb: replace __setup("nousb") with
 __module_param_call
Message-Id: <20060103124404.213b9257.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0601031530490.18243-100000@iolanthe.rowland.org>
References: <20060103113533.6ac3e351.zaitcev@redhat.com>
	<Pine.LNX.4.44L0.0601031530490.18243-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 15:34:27 -0500 (EST), Alan Stern <stern@rowland.harvard.edu> wrote:

> > I wish usb-handoff was exported similarly, because there's absolutely
> > no way to tell if it worked or was quietly ignored. And I abhor printks
> > in normal or success cases, so I do not want such indication.
> 
> usb-handoff no longer exists.  The kernel now takes USB host controllers
> away from the BIOS as soon as they are discovered.

This is why I wrote that I wish that it was exposed or exported.
It does not matter now, but it was a good example why the general
policy of exposure may be beneficial. English is very confusing.

-- Pete
