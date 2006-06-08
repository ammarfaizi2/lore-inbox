Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWFHKMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWFHKMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWFHKMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:12:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8025 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932111AbWFHKMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:12:37 -0400
Date: Thu, 8 Jun 2006 12:15:13 +0200
From: Jens Axboe <axboe@suse.de>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1 reiser4 oopses on mount
Message-ID: <20060608101513.GZ5207@suse.de>
References: <20060608081925.GX5207@suse.de> <1149761288.6336.23.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149761288.6336.23.camel@tribesman.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08 2006, Vladimir V. Saveliev wrote:
> Hello
> 
> On Thu, 2006-06-08 at 10:19 +0200, Jens Axboe wrote:
> > Hi,
> > 
> > With the recent talks on what to merge and what not, I thought I'd try
> > and see how reiser4 fares in the io testing I was going to do in
> > 2.6.17-rc6-mm1 anyways. I didn't get very far.
> > 
> 
> Am I correct that you have CONFIG_DEBUG_FS=n?
> If yes, please, try to test reiser4 with DEBUG_FS turned on, while I am
> making a fix for that.

Nope, I had CONFIG_DEBUG_FS=y when the oops happened. I then turned
debugfs off, and now it mounts fine.

So the opposite :-)

-- 
Jens Axboe

