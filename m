Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWEAUj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWEAUj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWEAUj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:39:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:36509 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932240AbWEAUj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:39:57 -0400
Date: Mon, 1 May 2006 13:38:15 -0700
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060501203815.GE19423@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2006 at 01:18:46AM -0400, Kyle Moffett wrote:
> On Apr 29, 2006, at 17:55:01, Greg KH wrote:
> >relayfs is for that.  You can now put relayfs files in any ram  
> >based file system (procfs, ramfs, sysfs, debugfs, etc.)
> 
> But you can't twiddle relayfs with echo and cat; it's more suited to  
> high-bandwidth transfers than anything else, no?

Yes.

