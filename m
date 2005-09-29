Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVI2UDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVI2UDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVI2UDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:03:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030202AbVI2UDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:03:20 -0400
Date: Thu, 29 Sep 2005 16:02:52 -0400
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Message-ID: <20050929200252.GA31516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <433BC9E9.6050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433BC9E9.6050907@pobox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 07:03:05AM -0400, Jeff Garzik wrote:
 > 
 > Just updated my KHGtG to include the latest goodies available in 
 > git-core, the Linux kernel standard SCM tool:
 > 
 > 	http://linux.yyz.us/git-howto.html
 > 
 > Several changes in git-core have made working with git a lot easier, so 
 > be sure to re-familiarize yourself with the development process.
 > 
 > Comments, corrections, and notes of omission welcome.  This document 
 > mainly reflects my typical day-to-day git activities, and may not be 
 > very applicable outside of kernel work.

You wrote..

$ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
$ cd linux-2.6
$ rsync -a --verbose --stats --progress \
  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
  .git/

Could be just..

$ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
$ cd linux-2.6
$ git pull

Likewise, in the next section, git pull doesn't need an argument
if pulling from the repo it cloned.

		Dave

