Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272556AbTGZQqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272560AbTGZQqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:46:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:11692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272556AbTGZQqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:46:02 -0400
Date: Sat, 26 Jul 2003 12:50:56 -0400
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030726165056.GA3168@kroah.com>
References: <200307262036.13989.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307262036.13989.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 08:36:13PM +0400, Andrey Borzenkov wrote:
> 
> So apparently I cannot rely on sysfs to get reliable persistent information 
> about physical location of devices.

That is correct, but you can get pretty close :)

> the point is - I want to create aliases that would point to specific slots. 
> I.e. when I plug USB memory stick in upper slot on front panel I'd like to 
> always create the same device alias for it.

Look at the udev announcement I posted to linux-kernel yesterday to see
how to do this.

thanks,

greg k-h
