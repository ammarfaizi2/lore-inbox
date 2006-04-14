Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWDNA7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWDNA7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWDNA7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:59:04 -0400
Received: from verein.lst.de ([213.95.11.210]:31924 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965080AbWDNA7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:59:02 -0400
Date: Fri, 14 Apr 2006 02:57:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, sfr@canb.auug.org.au,
       hch@lst.de, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 11/22] Fix block device symlink name
Message-ID: <20060414005729.GA11766@lst.de>
References: <20060413230141.330705000@quad.kroah.org> <20060413230807.GL5613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413230807.GL5613@kroah.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:08:07PM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> As noted further on the this file, some block devices have a / in their
> name, so fix the "block:..." symlink name the same as the /sys/block name.

shouldn't there be a common helper for both the symlink and the
/sys/block name so erros like this don't happen again?
