Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934284AbWKUBTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284AbWKUBTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWKUBTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:19:32 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10641 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S934281AbWKUBTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:19:31 -0500
Message-ID: <45625384.90601@us.ibm.com>
Date: Mon, 20 Nov 2006 17:16:52 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
CC: alexisb@us.ibm.com
Subject: Re: [PATCH 00/15] Roll-up of my libsas, aic94xx and sas_ata patches
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Hi all,
> 
> This is a roll-up of all of my patches against libsas, aic94xx and
> sas_ata to date.  The only new patches are #4-5 and #12-15; everything
> else has already been seen in some form on this mailing list.
> Hopefully this will make things a bit saner since most of these have
> been floating out over the past 3 weeks. :)
> 
> (Apologies for any stgit mail misconfiguration on my part.)

I've respun the non sas_ata patches from last week against scsi-misc:
http://sweaglesw.net/~djwong/docs/libsas-patches/ .  The *jejb*patch
files are pulled from aic94xx-sas, so I suppose it's not quite a pure
rebasing; however, some of those patches don't really make any sense
without those three included.

--D
