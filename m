Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTEBP5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbTEBP5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:57:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21916 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262963AbTEBP5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:57:51 -0400
Date: Fri, 2 May 2003 09:04:55 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] kill the last occurances of usb_serial_get_by_minor
Message-ID: <20030502160455.GA10397@kroah.com>
References: <20030502153723.GS21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502153723.GS21168@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 05:37:23PM +0200, Adrian Bunk wrote:
> I got an error at the final linking of 2.5.68-bk11. It seems the patch 
> below is needed.

Heh, you're using USB_SERIAL_CONSOLE?  crazy...

Anyway, yes, you're right.  I'll add this to my tree and send it off to
Linus in my next round of patches.  Thanks a lot for finding this and
the patch.

greg k-h
