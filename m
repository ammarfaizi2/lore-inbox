Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUCCPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUCCPUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:20:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:7836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262479AbUCCPUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:20:08 -0500
Date: Wed, 3 Mar 2004 07:15:00 -0800
From: Greg KH <greg@kroah.com>
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303151500.GD25687@kroah.com>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303095615.GA89995@weiser.dinsnail.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 10:56:15AM +0100, Michael Weiser wrote:
> On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
> > Major changes from the 019 version:
> > 	- new variable $local for the udev.permission file allows
> > 	  permissions to be set for the currently logged in user.
> Yay, just the other day I thought that might be a nice feature in
> concert with RedHat's/Fedora's pam_console module. Am I right in
> assuming that the current utmp based code will give the file to the user
> that most recently logged into the local console? This could cause some
> confusion with the pam_console-method which gives files to the user that
> logged in *first* on a local console.

I don't know, care to test it out?

thanks,

greg k-h
