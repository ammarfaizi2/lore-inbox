Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDJKRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDJKRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWDJKRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:17:36 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:54728 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751120AbWDJKRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:17:35 -0400
Message-ID: <443A307D.4060102@s5r6.in-berlin.de>
Date: Mon, 10 Apr 2006 12:16:29 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Hannes Reinecke <hare@suse.de>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, Denis Vlasenko <vda@ilport.com.ua>,
       SCSI List <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k
 of text
References: <200604100844.12151.vda@ilport.com.ua> <200604100903.35431.eike-kernel@sf-tec.de> <200604101015.36869.vda@ilport.com.ua> <200604100919.23244.eike-kernel@sf-tec.de> <443A2805.6000806@s5r6.in-berlin.de> <443A2CDB.5060404@suse.de>
In-Reply-To: <443A2CDB.5060404@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke wrote:
> Re multiplatform development: aic7{9,x}xx have ceased to be
> multiplatfrom since the integration of scsi_transport_spi.
> So I wouldn't worry too much about it.

Then it may be possible to save even more than 80k of text.
-- 
Stefan Richter
-=====-=-==- -=-- -=-=-
http://arcgraph.de/sr/
