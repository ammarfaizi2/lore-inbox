Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbTANLRB>; Tue, 14 Jan 2003 06:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbTANLRB>; Tue, 14 Jan 2003 06:17:01 -0500
Received: from holomorphy.com ([66.224.33.161]:40837 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262326AbTANLRA>;
	Tue, 14 Jan 2003 06:17:00 -0500
Date: Tue, 14 Jan 2003 03:25:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.bk no longer boots from NFS root after bk pull this morning
Message-ID: <20030114112549.GC919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E23E087.9020302@walrond.org> <20030114100900.GA919@holomorphy.com> <3E23E6B1.10807@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E23E6B1.10807@walrond.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Send in your .config, I heard a default enabled option having something
>> to do with "GSS" isn't playing nicely with others.

On Tue, Jan 14, 2003 at 10:30:09AM +0000, Andrew Walrond wrote:
> .config attached as requested
> # CONFIG_SUNRPC_GSS is not set

Okay, can you do bisection search on -bk vs. the last known working 
version of the kernel? It might take a well; best keep ccache handy.


Thanks,
Bill
