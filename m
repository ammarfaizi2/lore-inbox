Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTDGQNv (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTDGQNv (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:13:51 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:25838 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263496AbTDGQNu (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 12:13:50 -0400
Date: Mon, 7 Apr 2003 10:24:57 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 features/options
Message-ID: <20030407102457.V1422@schatzie.adilger.int>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0304071323240.15910@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.51.0304071323240.15910@dns.toxicfilms.tv>; from solt@dns.toxicfilms.tv on Mon, Apr 07, 2003 at 01:33:20PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 07, 2003  13:33 +0200, Maciej Soltysiak wrote:
> how do i see which features / options filesystem has set ?
> i think tune2fs can only set or clear the flags.
> 
> I am asking of this because i set some features on ext3, and i want
> to resize the fs using ext2resize (I have read it is okay to do that)
> and ext2resize says i have incomptible features set. And it is not
> about the journaling, because i have been resizing journaled fs earlier
> on.

Possibly you have files larger than 2GB and the "largefile" feature is
set?  If you get the CVS version of ext2resize it will fix this.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

