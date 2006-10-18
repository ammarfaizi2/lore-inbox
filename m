Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWJRROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWJRROc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWJRROb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:14:31 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:3050 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161226AbWJRROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:14:30 -0400
Date: Wed, 18 Oct 2006 19:11:32 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: linux-kernel@vger.kernel.org, jlamanna@gmail.com, ismail@pardus.org.tr
Subject: Re: [PATCH] Support ISO-9660 RockRidge v. 1.12 V2
Message-ID: <45366044.sFcrEOC5B77l5ep2%Joerg.Schilling@fokus.fraunhofer.de>
References: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
In-Reply-To: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lamanna <jlamanna@gmail.com> wrote:

>
> Joerg Schilling pointed out that RockRidge v. 1.12 extends the PX entry.
> This patch stores the inode number that is now included.
> He has also mentioned 'implementing support for new inode features' wrt to a
> mkisofs fingerprint. Perhaps that will come at a later date.
> Regardless, that can be built on this patch since now the inode number gets
> stored.
>
> This patch has been tested against mounting an ISO-9660 image in
> loopback that supports RockRidge v. 1.12 (thank you to Joerg for a beta 
> of mkisofs that does this).
> This should apply against the latest git.

If you did not test this as NFS server, you may have introduced a problem....


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
