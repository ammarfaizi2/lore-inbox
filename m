Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWBHAGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWBHAGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWBHAGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:06:24 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24306 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030301AbWBHAGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:06:23 -0500
Date: Tue, 07 Feb 2006 18:06:45 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6.15] frequent "BUG: soft lockup detected on CPU#0" in IDE
 subsystem
In-reply-to: <5DB5f-2uJ-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43E93615.3080902@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5DB5f-2uJ-21@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> kernel: 2.6.15
> system: 3.2GHz P4 hyperthreading, 1xIDE, 2GB ram
> it seems to happen (altough I'm really not sure!) when the system is
> under heavily load: > 8.0, while running sa-learn (the spamassassin
> bayes training tool)
> 

Lots of PIO transfers.. Is DMA not getting enabled on your drives?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

