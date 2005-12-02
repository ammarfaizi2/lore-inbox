Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVLBAjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVLBAjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVLBAjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:39:04 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49335 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932582AbVLBAjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:39:03 -0500
Date: Thu, 01 Dec 2005 18:38:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
In-reply-to: <5eRZp-5KA-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <438F9790.9060801@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5ePEj-2gB-9@gated-at.bofh.it> <5eQqA-3pv-7@gated-at.bofh.it>
 <5eRZp-5KA-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Jeff,
> 
> Good, this was the exact response that I was hoping for, as I've been told to
> convince Adaptec to drop the binary RAID drivers in favor of helping out dmraid
> development instead.  That process will probably be difficult, but at least I
> now have incontrovertible proof that nobody will bend over backwards to support
> them and that dmraid is the way to go.  Not that I'm terribly surprised by this.

It's good that there is a push to get non-binary-module support for 
these controllers in Linux. It's a shame that this is only happening now 
though.

It does rather suck that IBM changed to use this AIC79xx controller with 
"HostRAID" in the x346, x236, etc. servers. The last generation of 
servers (x235, x345) used an LSI Logic MPT Fusion controller which could 
do RAID 1 in hardware (or at least firmware) without a special driver - 
this sufficed for certain applications. With the new machines, RAID on 
the onboard controller requires using the stupid binary module which is 
only built against certain specific kernels, or using pure software RAID..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

