Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291121AbSBSKtE>; Tue, 19 Feb 2002 05:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291117AbSBSKsz>; Tue, 19 Feb 2002 05:48:55 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:7923 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291122AbSBSKsn>;
	Tue, 19 Feb 2002 05:48:43 -0500
Date: Tue, 19 Feb 2002 03:46:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Samium Gromoff <root@ibe.miee.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NE2k driver issue
Message-ID: <20020219034611.F24428@lynx.adilger.int>
Mail-Followup-To: Samium Gromoff <root@ibe.miee.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202191318.g1JDIcm12054@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202191318.g1JDIcm12054@ibe.miee.ru>; from root@ibe.miee.ru on Tue, Feb 19, 2002 at 04:18:38PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  16:18 +0300, Samium Gromoff wrote:
> With esd started the sound card generated 500-600 interrupts/second,
> with no esd, it didnt generated interrupts.

This is a known problem with esd - it plays "the sound of silence" all
the time.  This means it is generating interrupts even when you aren't
listening to anything.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

