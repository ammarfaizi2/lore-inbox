Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWCABIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWCABIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 20:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWCABIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 20:08:12 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41868 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751794AbWCABIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 20:08:10 -0500
Date: Tue, 28 Feb 2006 19:09:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Max mem space per process under  2.6.13-15.7-smp
In-reply-to: <5LmVi-6om-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4404F44D.1080600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5LmVi-6om-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Lampka wrote:
> Sorry to bother, 
> but what is the maximum amount of RAM that a *single* (!) process can
> address under a Kernel version 2.6.13-15.7-smp, with 
> 
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> 
> It seems that I can not get over 3 Gig border, but i need to, to solve
> my numerical problems :(.

If you use a kernel with the 4G-4G user-kernel space split patch, you 
can get a full 4GB. To get more than that you will need to move to 64-bit.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

