Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWBMREx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBMREx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWBMREx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:04:53 -0500
Received: from [205.233.219.253] ([205.233.219.253]:5045 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S932196AbWBMREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:04:53 -0500
Date: Mon, 13 Feb 2006 12:03:00 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
Message-ID: <20060213170300.GR3072@conscoop.ottawa.on.ca>
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk> <43F0B1AB.6010708@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0B1AB.6010708@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 05:19:55PM +0100, Stefan Richter wrote:
> 
> Jody, are you going to channel the patch through your tree?

It's part of an 8-patch series, so generally this would go through
somewhere more general like linux-scsi that can take the whole series.

I can take it if necessary though - let me know if so.

Cheers,
Jody

> BTW, a Prolific based enclosure indeed seems to be unable to handle
> CD-ROMs after scsiinfo treatment. An enclosure based on an old
> revision of TI StorageLynx apparently causes mode_sense -> check
> condition/ unit attention loops when scsiinfo tries to access some
> mode page.
> -- 
> Stefan Richter
> -=====-=-==- --=- -==-=
> http://arcgraph.de/sr/

-- 
