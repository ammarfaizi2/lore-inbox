Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUJGVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUJGVLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJGVJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:09:00 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33444 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268213AbUJGUpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:45:53 -0400
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
From: Dave Hansen <haveblue@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <4165A951.3060808@adaptec.com>
References: <1097178019.24355.39.camel@localhost>
	 <4165A369.60306@cybsft.com>  <4165A951.3060808@adaptec.com>
Content-Type: text/plain
Message-Id: <1097181937.25526.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 13:45:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 13:38, Luben Tuikov wrote:
> It is most likely the PCI ID patch which went into those drivers.
> You can back out only that change (drivers/scsi/aic7xxx) and
> try it.  (assuming you haven't changed anything else)

There's a lot of other gunk around there.  Is there a patch just for
that changeset somewhere?

-- Dave

