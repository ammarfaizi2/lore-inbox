Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWKOPXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWKOPXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWKOPXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:23:32 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:3859 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S1030557AbWKOPX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:23:28 -0500
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
From: Mathieu Fluhr <mfluhr@nero.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Phillip Susi <psusi@cfl.rr.com>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4559FBCF.9050203@gmail.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
	 <1163446372.15249.190.camel@laptopd505.fenrus.org>
	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
	 <4559FBCF.9050203@gmail.com>
Content-Type: text/plain
Organization: Nero AG
Date: Wed, 15 Nov 2006 16:19:18 +0100
Message-Id: <1163603958.3029.3.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 02:24 +0900, Tejun Heo wrote:
> > ... and the problem is not in accessing the device itself (this is
> > working like a charm) but understanding why a SCSI READ(10) cmd
> > sometimes fails as a ATA-padded READ(10) cmd - as discribed in the
> Annex
> > A of the MMC-5 spec - ALWAYS works.
> > -> I would suspect somehow a synchronisation problem somehow in the
> > translation of SCSI to ATA command...
> 
> Can you try the attached patch and see if anything changes?
> 

The patch _seems_ to solve my problem. I am just really astonished when
I read the diff file :D. Can I expect that it will be merged to the
official kernel sources ?

Thanks a lot for your answers!

