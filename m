Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTLQQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTLQQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:25:29 -0500
Received: from needs-no.brain.uni-freiburg.de ([132.230.63.23]:6425 "EHLO
	needs-no.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264481AbTLQQZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:25:25 -0500
Date: Wed, 17 Dec 2003 17:25:22 +0100 (MET)
From: Thomas Voegtle <thomas@voegtle-clan.de>
To: linux-kernel@vger.kernel.org
cc: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
In-Reply-To: <200312171119.39966.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.21.0312171721420.32339-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Gene Heskett wrote:

> I take that it is attempting to scan all 8 addresses of the scsi bus 
> even though its actually hitting the atapi stuff?  Or do I need an 
> even fresher version of cdrecord? or libscg?

Sorry, I shortend my output of cdrecord. With 2.6.0-test11 it looks like
this:

Using libscg version 'schily-0.7'
scsibus0:
cdrecord: Warning: controller returns wrong size for CD capabilities page.
        0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable CD-ROM
        0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *



-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------


