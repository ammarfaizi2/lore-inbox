Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSLaS30>; Tue, 31 Dec 2002 13:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLaS30>; Tue, 31 Dec 2002 13:29:26 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:24452 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264654AbSLaS3Z>; Tue, 31 Dec 2002 13:29:25 -0500
Date: Tue, 31 Dec 2002 10:44:03 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: networking for linux PDAs
To: rpgday@mindspring.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11E573.5080804@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The deal is that the 'CDCEther' (2.4) or 'cdc-ether' (2.5) driver
needs to blacklist the various devices using Lineo's "gadget side"
driver code, and it doesn't yet.  Presumably Brad would take a
patch for this.

The workaround I like best is adding it to /etc/hotplug/blacklist,
but I can imagine that not working for some folk (cable modems?).

- Dave


http://marc.theaimsgroup.com/?l=linux-kernel&m=104135894614196&w=2

