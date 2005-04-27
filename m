Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVD0UfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVD0UfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVD0UfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:35:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:62932 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261747AbVD0UfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:35:11 -0400
Date: Wed, 27 Apr 2005 22:34:51 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Greg KH <gregkh@suse.de>
Cc: erik@debian.franken.de, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [04/07] partitions/msdos.c fix
Message-ID: <20050427203440.GA26759@apps.cwi.nl>
References: <20050427171446.GA3195@kroah.com> <20050427171627.GE3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171627.GE3195@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 10:16:27AM -0700, Greg KH wrote:

> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> Erik reports this fixes an oops on boot for him.

No objections. But..

The purpose of this patch was not to fix an oops, but to avoid
partition table parsing in a situation where almost surely
no partition table is present.

If this fixes an oops, then I want to know precisely what oops.
No doubt that same oops could occur in other circumstances where
this patch does not happen to help.

Andries
