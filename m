Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318343AbSGRUOI>; Thu, 18 Jul 2002 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSGRUOI>; Thu, 18 Jul 2002 16:14:08 -0400
Received: from holomorphy.com ([66.224.33.161]:22668 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318343AbSGRUOI>;
	Thu, 18 Jul 2002 16:14:08 -0400
Date: Thu, 18 Jul 2002 13:17:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718201702.GR1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tobias Rittweiler <inkognito.anonym@uni.de>,
	linux-kernel@vger.kernel.org
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk> <20020718010617.GL1096@holomorphy.com> <1251977776.20020718114800@uni.de> <20020718104604.GQ1096@holomorphy.com> <139914576.20020718142939@uni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <139914576.20020718142939@uni.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 02:29:39PM +0200, Tobias Rittweiler wrote:
> >>EIP; c025a9d7 <find_next_offset+1f/28>   <=====
> >>ebx; c039e060 <llc_offset_table+60/f0>
> >>edx; c02db5d4 <llc_reject_state_transitions+9c/d8>
> >>ebp; c02dc85c <llc_conn_state_table+20/60>
> >>esp; c11f3f98 <END_OF_CODE+e55c28/????>
> Trace; c02589ac <mac_indicate+0/224>
> Trace; c0105073 <init+2b/178>
> Trace; c01056a4 <kernel_thread+28/38>

This looks pretty ugly, you're probably going to have to find someone
who's dealt with the LLC stack.


Cheers,
Bill
