Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbTIKHD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbTIKHD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:03:28 -0400
Received: from angband.namesys.com ([212.16.7.85]:63888 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S266176AbTIKHDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:03:21 -0400
Date: Thu, 11 Sep 2003 11:03:19 +0400
From: Oleg Drokin <green@namesys.com>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: inode generation numbers
Message-ID: <20030911070319.GA28563@namesys.com>
References: <200309092108.37805.bernd-schubert@web.de> <20030909140751.E18851@schatzie.adilger.int> <200309100053.23352.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309100053.23352.bernd-schubert@web.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 10, 2003 at 12:53:22AM +0200, Bernd Schubert wrote:

> It also works for reiserfs-partitions with the very same call, @reiserfs-team, 
> this won't change in the future, will it?

Yes, it is in there just to be compatible with ext2.

Be warned that on v3.5 filesystems this generation stuff is weakly implemented
and defaults to object id of parent directory.

Bye,
    Oleg
