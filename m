Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWBSS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWBSS1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWBSS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:27:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932170AbWBSS1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:27:51 -0500
Date: Sun, 19 Feb 2006 10:27:27 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, wolfgang@iksw-muees.de,
       martinmaurer@gmx.at, zaitcev@redhat.com
Subject: Re: [linux-usb-devel] Re: 2.6.15: usb storage device not detected
Message-Id: <20060219102727.32523b69.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0602191113430.9165-100000@netrider.rowland.org>
References: <20060218224924.737bd36b.zaitcev@redhat.com>
	<Pine.LNX.4.44L0.0602191113430.9165-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006 11:14:57 -0500 (EST), Alan Stern <stern@rowland.harvard.edu> wrote:

> Perhaps the device doesn't like the way you do GetMaxLUN after doing TEST 
> UNIT READY.

Quite possible. However, CaT is not a ub user normally, so we may never know.
Also, it leaves Martin's K7S5A. It seems that it may be easier to have the
old ZIP-100 locked to usb-storage with libusual. I am also concerned that
the old ZIP may require a manual spin-up, which ub does not do (my drive
spins up automatically).

-- Pete
