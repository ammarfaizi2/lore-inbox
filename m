Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVLVEmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVLVEmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLVEmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:42:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9928 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932338AbVLVEmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:42:07 -0500
Date: Wed, 21 Dec 2005 22:42:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
In-reply-to: <5maE0-21N-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43AA2E9A.1080007@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5maE0-21N-3@gated-at.bofh.it> <5maE0-21N-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> Well, the other way around is to upgrade e1000 driver in the 2.4.21EL-smp,
> as the machine I'm using is quite new, and RHES3 kernel can't find the
> Ethernet device, so the machine has no network.
> My first idea was to consider this as an opportunity to upgrade to the
> latest 2.4.x kernel, but reading you, this looks like a bad idea...
> 2.6.x would be better ?

First make sure you have the latest RHEL3 errata kernel installed. If 
that still doesn't work, you could install the latest e1000 driver 
module from Intel.

Later vanilla 2.4 kernels are not necessarily an "upgrade" from Red Hat 
kernels based on older 2.4 versions as you lose all the Red Hat patches 
like NPTL and the O(1) scheduler.

If you are going to go to a 2.6 kernel you might as well just go to a 
newer distribution.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

