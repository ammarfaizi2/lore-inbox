Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319584AbSH3PPP>; Fri, 30 Aug 2002 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319588AbSH3PPP>; Fri, 30 Aug 2002 11:15:15 -0400
Received: from holomorphy.com ([66.224.33.161]:37256 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319584AbSH3PPP>;
	Fri, 30 Aug 2002 11:15:15 -0400
Date: Fri, 30 Aug 2002 08:19:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: vantuyl@csc.smsu.edu, bryon@csc.smsu.edu, linux-kernel@vger.kernel.org
Subject: Re: [qlogicisp.c PROBLEM 2.5] OOPS: "Unable to handle kernel paging request ..."
Message-ID: <20020830151913.GL888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	vantuyl@csc.smsu.edu, bryon@csc.smsu.edu,
	linux-kernel@vger.kernel.org
References: <20020830103046.B107@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020830103046.B107@sexything>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:30:46AM +0200, Morten Helgesen wrote:
> Hey, Jason and Bryon!
> Got this one last night - it is def. reproducible. Vanilla 2.5.32.
> Haven't got time to look into this myself until tonight, so I thought
> I should let you guys know. 
> Anyone on lkml with comments ? I don`t get this OOPS with 2.4.19, and 
> the changes from qlogicisp.c in 2.4.19 to qlogicisp.c in 2.5.32 look
> minimal. Only cli -> spinlock and io_request_lock -> host->host_lock
> as far as I can see from a quick glance.

This happens routinely to me as well.


Cheers,
Bill
