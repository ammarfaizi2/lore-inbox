Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUKXCDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUKXCDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKXCDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:03:04 -0500
Received: from linuxfools.org ([216.107.2.99]:33975 "EHLO loki.linuxfools.org")
	by vger.kernel.org with ESMTP id S261674AbUKXCDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:03:00 -0500
Date: Tue, 23 Nov 2004 21:30:13 -0500
From: jhigdon@linuxfools.org
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: Ake <Ake.Sandgren@hpc2n.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failure
Message-ID: <20041124023013.GA2945@linuxfools.org>
References: <2E314DE03538984BA5634F12115B3A4E01BC40DC@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC40DC@email1.mitretek.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:39:13AM -0500, Piszcz, Justin Michael wrote:
> This is a known problem with the Intel Gigabit NIC and possibly other
> NIC's dealing with TSO (tcp segmentation offload).
> 
> Either try turning it off (with ethtool) or wait until 2.6.10 is
> released or try the latest -mm tree as Andrew Morton is working on
> fixing this issue.
> 
> This problem began with 2.6.9 and has been reported on the list quite a
> few times now :)
> 
> 

Seeing it with Broadcom gigabit too BCM5704. I am trying .10-rc2 and
havent seen any problems yet, but with min_free_kbytes set to 8192
instead of the previous default this problem took 3-5 days to show
itself, hopefully that wont be the case with this kernel.


