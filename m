Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKUUMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKUUMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKUUMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:12:52 -0500
Received: from web34111.mail.mud.yahoo.com ([66.163.178.109]:22635 "HELO
	web34111.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750712AbVKUUMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:12:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RGSiKeV3ZwbWUw4ht71kJ8torDnhMXZC5nBAhjBeN9BUC560Y0AIgL6DTl2sqEIEI/FP0VS/AO8KDjMyPDbJlAgsKSRPK/ZiQVH3P0HAgZn3iuOAfYQvS8v5WcOK/datQTNfQjiG5aD5gotARZ4dPa1AK3wtQedSo8KKiso5fL4=  ;
Message-ID: <20051121201250.28812.qmail@web34111.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 12:12:50 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: linux-kernel@vger.kernel.org
In-Reply-To: <438208A1.5020300@citi.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a smaller test case (4 system calls, and a memset), that causes the test case to hang in
an
> unkillable state*, and makes the system load consume an entire CPU.

Problem still exists in -rc2, but OProfile shows slightly different results:
samples  %        symbol name
2919823  86.8716  unmap_mapping_range
163379    4.8609  _raw_spin_trylock
36453     1.0846  prio_tree_first

-Kenny



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
