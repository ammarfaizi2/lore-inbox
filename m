Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTCLAaU>; Tue, 11 Mar 2003 19:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262972AbTCLAaT>; Tue, 11 Mar 2003 19:30:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:59101 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261708AbTCLA16>; Tue, 11 Mar 2003 19:27:58 -0500
Date: Tue, 11 Mar 2003 16:29:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
Message-ID: <47650000.1047428943@flay>
In-Reply-To: <20030311162153.493a305e.akpm@digeo.com>
References: <45750000.1047426594@flay> <20030311162153.493a305e.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm getting lots of these messages whilst running big SDET runs on
>> an 16-way machine ... anyone recognize them?
>> (64-bk3 + a few patches).
>> 
>> dev (pts(136,0)) tty->count(4) != #fd's(3) in release_dev
> 
> The file_list_lock patches affect this.  Do you have those applied?

Yes, sorry ... was running out the door, crap description ;-)
 
> If so, and if it is repeatable, this might help.  (Unlikely, but it might).

Mmm ... OK. will try that. Thanks,

M.

