Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbUDGHRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUDGHRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:17:17 -0400
Received: from macvin.cri2000.ens-lyon.fr ([140.77.13.138]:45964 "EHLO
	macvin.cri2000.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S264123AbUDGHPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:15:20 -0400
Date: Wed, 7 Apr 2004 09:15:18 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.5-mm2
Message-ID: <20040407071518.GJ1139@ens-lyon.fr>
References: <20040406223321.704682ed.akpm@osdl.org> <20040407065154.GG1139@ens-lyon.fr> <20040407001004.0360a049.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040407001004.0360a049.akpm@osdl.org>
X-Operating-System: Linux 2.6.5 i686
Organization: Ecole Normale Superieure de Lyon
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/04/2004-09:11, Andrew Morton wrote:

> Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
> >
> >  CC [M]  drivers/scsi/sr.o
> >  	    drivers/scsi/sr.c: In function scsi_cd_get':
> >  	    drivers/scsi/sr.c:128: error: structure has no member named kobj'
> 
> It looks like Mr SCSI forgot to commit his changes to sr.h.
> 
> Here's a backout patch which should get you going again.

Works great, thanks a lot.
--
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France
