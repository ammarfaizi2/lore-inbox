Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbUDGGwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDGGwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:52:49 -0400
Received: from macvin.cri2000.ens-lyon.fr ([140.77.13.138]:37772 "EHLO
	macvin.cri2000.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S264112AbUDGGv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:51:58 -0400
Date: Wed, 7 Apr 2004 08:51:55 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm2
Message-ID: <20040407065154.GG1139@ens-lyon.fr>
References: <20040406223321.704682ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040406223321.704682ed.akpm@osdl.org>
X-Operating-System: Linux 2.6.5 i686
Organization: Ecole Normale Superieure de Lyon
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2004-07:40, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm2/
> 
> 
> - Merged up Ian Kent's autofs4 patches
> 
> - Various fixes and speedups.


Hi Andrew,

When building on my Compaq EvoN600c, I get this compile error :

CC [M]  drivers/scsi/sr.o
	    drivers/scsi/sr.c: In function scsi_cd_get':
	    drivers/scsi/sr.c:128: error: structure has no member named kobj'
	    drivers/scsi/sr.c: In function scsi_cd_put':
	    drivers/scsi/sr.c:135: error: structure has no member named kobj'
	    drivers/scsi/sr.c: In function sr_probe':
	    drivers/scsi/sr.c:554: error: structure has no member named kobj'
	    drivers/scsi/sr.c:555: error: structure has no member named kobj'
	    drivers/scsi/sr.c: In function sr_kobject_release':
	    drivers/scsi/sr.c:904: error: structure has no member named kobj'
	    drivers/scsi/sr.c:904: warning: type defaults to int' in
declaration of __mptr'
drivers/scsi/sr.c:904: warning: initialization from incompatible pointer type
drivers/scsi/sr.c:904: error: structure has no member named kobj'
make[2]: *** [drivers/scsi/sr.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

2.6.5-mm1 and previous compiled without any problem.
.config attached.

Best Regards
--
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France
