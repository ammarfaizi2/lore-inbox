Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTLBEPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 23:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTLBEPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 23:15:24 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29706
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264305AbTLBEPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 23:15:22 -0500
Date: Mon, 1 Dec 2003 20:15:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Message-ID: <20031202041513.GN1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Linux-raid maillist <linux-raid@vger.kernel.org>,
	linux-lvm@sistina.com
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCC0EE0.9010207@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 09:02:40PM -0700, Kevin P. Fleming wrote:
> Tested with mem=800m, problem still occurs. Additional test was done 
> without device-mapper in place, though, and I could not reproduce the 
> problem! I copied > 500MB of stuff to the XFS filesystem created using 
> the entire /dev/md/0 device without a single unusual message. I then 
> unmounted the filesystem and used pvcreate/vgcreate/lvcreate to make a 
> 3G volume on the array, made an XFS filesystem on it, mounted it, and 
> tried copying data over. The oops message came back.

Can you try with DM on regular disk tm, instead of sw raid?
