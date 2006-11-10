Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946057AbWKJIgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946057AbWKJIgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946058AbWKJIgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:36:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:7073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946057AbWKJIgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:36:06 -0500
Date: Fri, 10 Nov 2006 15:53:36 +0900
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, pavel@ucw.cz
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061110065336.GA13646@kroah.com>
References: <20061108090454.dba20e01.randy.dunlap@oracle.com> <OF2A3BB933.427A044B-ON41257220.006509CA-41257220.00656F8A@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2A3BB933.427A044B-ON41257220.006509CA-41257220.00656F8A@de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:27:56PM +0100, Michael Holzheu wrote:
> If you want to export data to userspace via a virtual filesystem
> like sysfs, the following rules are recommended:

Um, does this mean you expect us to change all of the currently existing
sysfs file names?  And people get mad at me when I just move sysfs
symlinks around...

Look at the hwmon drivers, and the documentation in
Documentation/hwmon/sysfs-interface for a description of how we have
been documenting this already.

In short, I don't really think we need to encode the units in the file
name, somehow we have done pretty well without it so far :)

thanks,

greg k-h
