Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVBCAzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVBCAzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVBCAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:51:56 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:42549 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262704AbVBCAeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:34:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o8ffVni1CVS3dMP1BEwUkFJEYwAZaOeejexWHJ7+isOP8OM1Rz23XHHFIs7kev64qM2RGeY1IbVoMCPDh6zFlDP15qpnnaYQ3QGhEQq/IXrSBmii/aDFiBaVM/h9ypn/xuJ8QDmIE93mLRk6OX3acu/23o9rwrsbHx6+VWQzBAA=
Message-ID: <58cb370e05020216334656aed2@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:33:53 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 09/29] ide: __ide_do_rw_disk() lba48 dma check fix
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025142.GJ621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025142.GJ621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:51:42 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 09_ide_do_rw_disk_lba48_dma_check_fix.patch
> >
> >       In __ide_do_rw_disk(), the shifted block, instead of the
> >       original rq->sector, should be used when checking range for
> >       lba48 dma.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

good catch!  applied
