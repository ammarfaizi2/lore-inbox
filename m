Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSIAXRH>; Sun, 1 Sep 2002 19:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSIAXRH>; Sun, 1 Sep 2002 19:17:07 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:65444 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S318159AbSIAXRG>; Sun, 1 Sep 2002 19:17:06 -0400
Date: Sun, 01 Sep 2002 16:21:12 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH][2.5] set pci dma mask for ohci-hcd
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D72A0E8.4030303@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last I looked, that value was documented to be the
default.  Setting the default is not necessary, and
if it were done it should be done once (hcd.c) not
get repeated for every driver.

- Dave

