Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWGJNWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWGJNWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGJNWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:22:11 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:32714 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751357AbWGJNWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:22:09 -0400
Message-ID: <44B253CE.3030308@s5r6.in-berlin.de>
Date: Mon, 10 Jul 2006 15:19:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394: aborting transmission
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de> <44B203F4.1030903@s5r6.in-berlin.de> <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
In-Reply-To: <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 10 Jul 2006, Stefan Richter wrote:
>> Perhaps you should add a printk at the beginning of input's init
>> function. The delay could happen during the startup of the input layer
>> instead of the 1394 drivers.

PS: Another simple test would be to boot with IEEE 1394 modules moved
away so that they are not loaded.
-- 
Stefan Richter
-=====-=-==- -=== -=-=-
http://arcgraph.de/sr/
