Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSIWNyU>; Mon, 23 Sep 2002 09:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSIWNyU>; Mon, 23 Sep 2002 09:54:20 -0400
Received: from holomorphy.com ([66.224.33.161]:50837 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261474AbSIWNyT>;
	Mon, 23 Sep 2002 09:54:19 -0400
Date: Mon, 23 Sep 2002 06:50:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 vs. 2.5.38-mm1 dbench 512 oprofiles
Message-ID: <20020923135040.GZ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org
References: <20020923053600.GJ25605@holomorphy.com> <20020923054604.GY3530@holomorphy.com> <20020923144055.A29900@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020923144055.A29900@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 06:02:15AM +0000, William Lee Irwin III wrote:
>> sorry real 2.5.38-mm1 profile:
>> c01053dc 884615995 93.5551     poll_idle
>> c0114c28 38573436 4.07944     load_balance

On Mon, Sep 23, 2002 at 02:40:55PM +0530, Dipankar Sarma wrote:
> Any idea why scheduler time shoot up with mm1 ? The RCU core
> patch (rcu_ltimer) in mm1 doesn't force any context switches, so it
> can't be that.

Basically, the time once spent in busywait becomes idle time.


Cheers,
Bill
