Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWDJKUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWDJKUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDJKUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:20:36 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:59848 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751125AbWDJKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:20:35 -0400
Message-ID: <443A3131.1050103@s5r6.in-berlin.de>
Date: Mon, 10 Apr 2006 12:19:29 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-scsi@vger.kernel.org, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k
 of text
References: <200604100844.12151.vda@ilport.com.ua> <443A1AA5.8060707@s5r6.in-berlin.de> <200604101156.30717.vda@ilport.com.ua>
In-Reply-To: <200604101156.30717.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 10 April 2006 11:43, Stefan Richter wrote:
>> It is obviously necessary to modify the Makefile to have aic7?xx_osm_o.o
>> and aic7?xx_inline.o linked to an appropriate .ko file.
> 
> I did compile test my changes.

Sure, if you #include .c files (which is awkward), there are no
additional .o files which would need to be added to the Makefile.
-- 
Stefan Richter
-=====-=-==- -=-- -=-=-
http://arcgraph.de/sr/
