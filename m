Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291333AbSBZRBV>; Tue, 26 Feb 2002 12:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSBZRBP>; Tue, 26 Feb 2002 12:01:15 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:1521 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291484AbSBZRAs>;
	Tue, 26 Feb 2002 12:00:48 -0500
Date: Tue, 26 Feb 2002 10:00:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Getting incorrect size on large files from DVD
Message-ID: <20020226100029.G12832@lynx.adilger.int>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202261551150.14140-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0202261551150.14140-100000@mustard.heime.net>; from roy@karlsbakk.net on Tue, Feb 26, 2002 at 03:53:17PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  15:53 +0100, Roy Sigurd Karlsbakk wrote:
> Reading > 2^31bytes files, results in Linux reporting extremely low size -
> typically <10MB. Putting the same DVD disc into a Windoze box works fine.
> 
> Anyone have any ideas?

Are you mounting it as UDF or as ISO?  You should use UDF for DVD discs.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

