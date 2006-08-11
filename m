Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWHKIws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHKIws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWHKIws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:52:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53398 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750914AbWHKIwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:52:46 -0400
Message-ID: <44DC455A.2090705@garzik.org>
Date: Fri, 11 Aug 2006 04:52:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH 1/2] Add SATA support to libsas
References: <44DBE943.4080303@us.ibm.com>
In-Reply-To: <44DBE943.4080303@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Hook the scsi_host_template functions in libsas to delegate
> functionality to libata when appropriate.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

One piece that seems to be distinctly absent is controlling the SATA 
phy, rather than faking it...

	Jeff



