Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272025AbRH2RmF>; Wed, 29 Aug 2001 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272028AbRH2Rl4>; Wed, 29 Aug 2001 13:41:56 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:33015 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272027AbRH2Rls>; Wed, 29 Aug 2001 13:41:48 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 29 Aug 2001 11:41:26 -0600
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 -> reiserfs conversion?
Message-ID: <20010829114126.G24270@turbolinux.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108291640540.4463-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0108291640540.4463-100000@mustard.heime.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 29, 2001  16:44 +0200, Roy Sigurd Karlsbakk wrote:
> does any of you know if there are any plans to create an ext22reiserfs
> utility?

It is probably more dangerous and difficult than it is worth.  Use a
backup/restore, that way you also have a backup in case there is a
problem with the conversion.

Since you would ALWAYS do a backup before performing such an operation
(right????) then doing the restore to the newly formatted reiserfs
partition would probably take less time than any kind of conversion
would take (and be a LOT more robust, as well as doing a "defrag"),
so you are way better off to do it that way.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

