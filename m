Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTDOBMZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTDOBMZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:12:25 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:35553 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S264023AbTDOBMY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 21:12:24 -0400
Date: Mon, 14 Apr 2003 21:19:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304142122_MC3-1-346E-A549@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If RAID1 can use the generic elevator then it should. I
> guess it can't though.


  No, but it is feeding IO requests into the elevators of the 
block devices below it.  For a given read, all it wants to do
is pick one device to handle the work.  If it could look into
the queues maybe it could make better decisions.

--
 Chuck
