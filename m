Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTEKDky (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 23:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTEKDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 23:40:54 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:17401 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262182AbTEKDkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 23:40:51 -0400
Date: Sat, 10 May 2003 23:50:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: don't use cheap switches under some scenarios
To: Xinwen Fu <xinwenfu@cs.tamu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305102353_MC3-1-385A-BC34@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xinwen Fu wrote:

> The switching table is
> messed up by the intense traffic, we believe. Other cheaper switches
> (netgear fast esthernet switch FS108 ) have the same problem.

  What do you mean by "intense traffic?"  Many switches will get
confused if you fill their tables with a large number of different
addresses.  Is someone maybe spoofing MAC addresses on your net?
Or is the switch plugged into a larger switched network where it will
see many different MAC addresses on the uplink port?

  Also, almost every switch will flood all ports with traffic for
machines that have disappeared recently (disconnected or changed
their MAC addresses.)  High-end switches have settings to control
this problem but it's impossible to avoid some leakage.

  Never count on an ethernet switch to provide privacy for traffic 
on a single VLAN.
