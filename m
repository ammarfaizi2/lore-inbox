Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRIQQyy>; Mon, 17 Sep 2001 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271856AbRIQQyn>; Mon, 17 Sep 2001 12:54:43 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59895 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271847AbRIQQyk>; Mon, 17 Sep 2001 12:54:40 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 17 Sep 2001 10:54:54 -0600
To: Juan <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 journal on its own device?
Message-ID: <20010917105454.B26122@turbolinux.com>
Mail-Followup-To: Juan <piernas@ditec.um.es>, linux-kernel@vger.kernel.org
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 17, 2001  17:54 +0200, Juan wrote:
> I have been browsing the Ext3 source (version 0.0.7a), and it seems
> impossible to use a block device as an Ext3 journal. Is that true?.

The code to support this is not included in the 2.2 ext3 only in 2.4 ext3.
There was a patch for 2.2 journal devices long ago, but I'm not sure if
it was updated to work with the new "format" of the external journal.  It
was posted to ext2-devel by Marcelo Tossatti, probably 6 months ago or more.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

