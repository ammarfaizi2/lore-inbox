Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUBYMGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUBYMGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:06:33 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:59609 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261281AbUBYMGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:06:32 -0500
Date: Wed, 25 Feb 2004 12:04:51 +0000
From: Dave Jones <davej@redhat.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: greg@kroah.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-uhci rmmod fun
Message-ID: <20040225120451.GC11203@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Johannes Erdfelt <johannes@erdfelt.com>, greg@kroah.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040225005241.GB11203@redhat.com> <20040225031348.GM16632@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225031348.GM16632@sventech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:13:48PM -0800, Johannes Erdfelt wrote:

 > > (00:52:08:root@mindphaser:davej)# lsmod | grep floppy
 > > (00:52:39:root@mindphaser:davej)# modprobe usb-uhci
 > > (00:52:48:root@mindphaser:davej)# lsmod | grep floppy
 > > (00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
 > > (00:53:11:root@mindphaser:davej)# lsmod | grep floppy
 > > floppy                 58260  0
 > > (00:53:13:root@mindphaser:davej)#
 > > 
 > > Unloading the usb controller loads the floppy controller!?
 > 
 > That can't be right. You're loading usb-uhci, then unloading uhci_hcd.
 > 
 > You should have only have one, depending on the version of the kernel.

Err, yeah. ignore the modprobe part. uhci_hcd was already loaded during boot..

		Dave



