Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFJN6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTFJN6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:58:06 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:32661 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S262771AbTFJN6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:58:04 -0400
Date: Tue, 10 Jun 2003 16:11:42 +0200 (MET DST)
From: =?ISO-8859-2?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
In-Reply-To: <20030610145721.A27349@infradead.org>
Message-ID: <Pine.GSO.4.00.10306101611260.15153-100000@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig:
> > Is the case the same with the SCSI drivers, IDE drivers, network core,
> > filesystems and everything that creates directories and file entries in
> > procfs?
> 
> No.  The problem with comx is that unlike other driver it doesn't
> not use the published procfs API but instead tries to implemented
> half of an own filesystem abusing procfs infrastructure.

It'll get updated and fixed.

                 ----------------------------------------------
                 |  If you can't learn to do something well,  |
                 |      learn to enjoy doing it poorly.       |
                 ----------------------------------------------

