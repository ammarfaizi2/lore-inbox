Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWHYL6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHYL6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHYL6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:58:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:6070 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750744AbWHYL6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:58:50 -0400
Date: Fri, 25 Aug 2006 13:58:49 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060825115849.GG221@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060825115532.GF221@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825115532.GF221@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
oh and before I forget about this:

        Turn SATA in Bios to compatibility mode And don't forget about
        the following kernel patch: Otherwise you don't have a disk
        after the resume. But the buffer cache is still there. ;-)

http://vizzzion.org/stuff/thinkpad-t60/libata-acpi.diff

and yes, it is currently no fun to run a t60 under linux but it can only
get better.

        Thomas
