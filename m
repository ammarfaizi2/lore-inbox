Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJRATK>; Thu, 17 Oct 2002 20:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbSJRATK>; Thu, 17 Oct 2002 20:19:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40092 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262276AbSJRATJ>; Thu, 17 Oct 2002 20:19:09 -0400
Date: Thu, 17 Oct 2002 17:26:20 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.42 kernel BUG at drivers/base/core.c:251!
Message-ID: <20021018002620.GA1312@beaverton.ibm.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <200210151724.g9FHOI426577@eng2.beaverton.ibm.com> <Pine.LNX.4.44.0210171707350.1038-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210171707350.1038-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel [mochel@osdl.org] wrote:
> The BUG() was added to catch people still using the wrong call. The SCSI 
> patch that Mike Anderson posted last night should have this fixed in it.

I removed the scsi mid layer ones in my patch.

Patrick Mansfield re-posted a patch yesterday to cover the sg and other
scsi upper level drivers not alreay corrected. Here is a pointer to
Patrick's mail.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103479992624108&w=2

-andmike
--
Michael Anderson
andmike@us.ibm.com

