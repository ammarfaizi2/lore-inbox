Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJLRwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJLRwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJLRwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:52:33 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:40897 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266611AbUJLRvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:51:18 -0400
Date: Tue, 12 Oct 2004 19:51:17 +0200
From: bert hubert <ahu@ds9a.nl>
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 USB storage problems
Message-ID: <20041012175117.GA11113@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>,
	linux-kernel@vger.kernel.org
References: <200410121424.59584.worf@sbox.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410121424.59584.worf@sbox.tu-graz.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:24:59PM +0200, Wolfgang Scheicher wrote:
> 
> I'm sorry for not being able to track down the issue better:
> 
> if i mount my usb-stick ( Sandisk Micro 256MB, USB2.0, FAT ), write a file 
> (for example 4MB) to it and unmount or sync, then there is a lot of activity 
> on the stick, but the unmount or sync doesn't finish ( waited > 10 Minutes - 
> should not take more than 1-2 sec ).

Can you run vmstat 1 during this process - so start vmstat 1 before umount,
and then umount but leave it running.

> any hints? any patches i shall try?

Please provide dmesg output, and vmstat 1.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
