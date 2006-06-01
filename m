Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWFBMWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWFBMWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWFBMWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:22:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45801 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751308AbWFBMWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:22:22 -0400
Subject: Re: promise 20268 dma lockups with 2.4 & 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1146881315.3026.2.camel@localhost>
References: <Pine.LNX.4.64.0604301535500.1829@tassadar.physics.auth.gr>
	 <1146881315.3026.2.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 18:00:03 +0100
Message-Id: <1149181204.12932.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-05-06 at 04:08 +0200, Kasper Sandberg wrote:
> this seems to be a problem with promise ultra 133 TX2 aswell.. i tried
> contacting promise, and the people listed in the driver file, no
> response... i have myself pretty much given up on getting this solved. i
> dont have the nessecary expertise myself, and i cant get in touch with
> those who do.. this has also been posted to lkml before..

I would suggest trying the IDE maintainer and linux-ide list. There is
also an under development libata driver to replace the old IDE driver
which is maintained and actively developed. It can be found in the -mm
patch set.

