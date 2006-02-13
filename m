Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBMRhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBMRhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBMRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:37:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22699 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932120AbWBMRhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:37:17 -0500
Date: Mon, 13 Feb 2006 18:37:16 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.173317.6634.atrey@ucw.cz>
References: <43F097AE.nailKUSK1MJ9O@burner> <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE> <20060213095038.03247484.seanlkml@sympatico.ca> <43F0A771.nailKUS131LLIA@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner> <mj+md-20060213.164948.25807.atrey@ucw.cz> <43F0BA53.nailMDD11T4U8@burner> <mj+md-20060213.171329.3029.atrey@ucw.cz> <43F0C19C.nailMDR1O1BOX@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0C19C.nailMDR1O1BOX@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The warnings are not silly. They could have been removed long ago
> if the icd-scsi DMA bug was fixed.

This doesn't make sense, the usual case when the warning is printed,
that is referring to /dev/hd* directly, doesn't use ide-scsi at all.
Hence the only logical warning would be exactly the opposite: warn the
user if he uses ide-scsi, because you know it's broken.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The number of UNIX installations has grown to 10, with more expected.  (6/72)
