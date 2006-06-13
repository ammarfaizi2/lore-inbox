Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932874AbWFMEg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWFMEg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWFMEg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:36:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932874AbWFMEg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:36:28 -0400
Date: Tue, 13 Jun 2006 14:35:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060613143559.B867599@wobbly.melbourne.sgi.com>
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <Pine.LNX.4.61.0606101237020.23706@yvahk01.tjqt.qr> <448ADF8D.4050201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <448ADF8D.4050201@garzik.org>; from jeff@garzik.org on Sat, Jun 10, 2006 at 11:04:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 11:04:45AM -0400, Jeff Garzik wrote:
> Jan Engelhardt wrote:
> > I do not know much about XFS's realtime feature, but from what I have read 
> 
> I _think_ people are referring to GRIO when they mention that:
> 

No, thats something else.  The realtime feature is a mechanism
XFS provides for separating out data IOs for specific files from
metadata/log IOs.  This is CONFIG_XFS_RT in the kernel sources.

cheers.

-- 
Nathan
