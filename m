Return-Path: <linux-kernel-owner+w=401wt.eu-S1753545AbXACJgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXACJgN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbXACJgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:36:13 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:50971 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbXACJgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:36:12 -0500
X-Greylist: delayed 1521 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 04:36:12 EST
Message-ID: <459B731A.301@web.de>
Date: Wed, 03 Jan 2007 10:10:50 +0100
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       saw@saw.sw.com.sg, Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [2.6 patch] the scheduled eepro100 removal
References: <20070102215726.GC20714@stusta.de>
In-Reply-To: <20070102215726.GC20714@stusta.de>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the scheduled removal of the eepro100 driver.
> 

I'm sorry to disturb the schedule, but I'm not sure right now if this
pending issue of the e100 was meanwhile solved or declared a non-issue:

http://lkml.org/lkml/2006/9/8/105

Auke, can you confirm that it makes sense to re-test? IIRC, our private
thread ended without resolution after I discovered that the chip
revision makes the difference for me. Looked like it is either handled
incorrectly by e100 or screwed up on that board.

Jan
