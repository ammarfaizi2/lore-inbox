Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWFIVbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWFIVbg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbWFIVbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:31:35 -0400
Received: from [80.71.248.82] ([80.71.248.82]:47799 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030520AbWFIVbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:31:34 -0400
X-Comment-To: Joel Becker
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	<1149880865.22124.70.camel@localhost.localdomain>
	<m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org>
	<m3wtbq5dgw.fsf@bzzz.home.net>
	<20060609204418.GG3574@ca-server1.us.oracle.com>
	<m3fyie5a19.fsf@bzzz.home.net>
	<20060609211123.GI3574@ca-server1.us.oracle.com>
	<m364ja58m8.fsf@bzzz.home.net>
	<20060609212905.GK3574@ca-server1.us.oracle.com>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Sat, 10 Jun 2006 01:33:36 +0400
In-Reply-To: <20060609212905.GK3574@ca-server1.us.oracle.com> (Joel Becker's message of "Fri, 9 Jun 2006 14:29:05 -0700")
Message-ID: <m31wty580f.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Joel Becker (JB) writes:

 JB> On Sat, Jun 10, 2006 at 01:20:31AM +0400, Alex Tomas wrote:
 >> two point here:
 >> a) warnings should be made visible at mount time,
 >> something like printk(KERN_CRIT ...)

 JB> 	Too late, they're already broken!

not at mount time, only upon first file creation.

thanks, Alex

PS. need to think about your tune2fs/mke2fs proposal ... thanks.
