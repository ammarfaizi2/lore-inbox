Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVACVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVACVUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVACVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:14:06 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:14098 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261874AbVACVIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:08:22 -0500
Date: Mon, 3 Jan 2005 22:10:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: jthiessen@penguincomputing.com, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103221014.381efab7.khali@linux-fr.org>
In-Reply-To: <20050103205231.GK9923@schnapps.adilger.int>
References: <41D5D075.4000200@paradyne.com>
	<20050101001205.6b2a44d3.khali@linux-fr.org>
	<20050103194355.GA11979@penguincomputing.com>
	<20050103201056.3c55e330.khali@linux-fr.org>
	<20050103213707.GA12765@penguincomputing.com>
	<20050103205231.GK9923@schnapps.adilger.int>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, on a completely "I don't know what the hell I'm talking about"
> point, it seems odd that for values named "0_3" and "4_7" you would
> upshift the "4_7" value 8 bits instead of 4, but it could be just a
> bad choice of variable names.

Actually each divider is stored on 2 bits, so both the names and the
shift look OK to me.

-- 
Jean Delvare
http://khali.linux-fr.org/
