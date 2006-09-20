Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWITXRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWITXRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWITXRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:17:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47494 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750817AbWITXRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:17:45 -0400
Message-ID: <4511CC17.4020307@us.ibm.com>
Date: Wed, 20 Sep 2006 16:17:43 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Moore, Eric" <Eric.Moore@lsil.com>
CC: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-Initiator SAS
References: <664A4EBB07F29743873A87CF62C26D7032CDC0@NAMAIL4.ad.lsil.com>
In-Reply-To: <664A4EBB07F29743873A87CF62C26D7032CDC0@NAMAIL4.ad.lsil.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Eric wrote:

> Which expander are you using?  I believe James has some sata work
> arounds
> for the sasx12, which has byte ordering issues.

A Vitesse VSC7160.

Also, I think I might have complained about I/O errors accessing the
SATA disk via mptsas--the SATA disk that we were using (Maxtor 6Y080M0)
yields the same errors when attached to the HBA.  I put in a Hitachi
SATA disk and it was fine with both controllers.

--D
