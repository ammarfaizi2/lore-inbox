Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTEAPuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEAPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:50:07 -0400
Received: from siaag1ae.compuserve.com ([149.174.40.7]:8686 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261437AbTEAPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:50:04 -0400
Date: Thu, 1 May 2003 12:00:59 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel source tree splitting
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305011202_MC3-1-36E2-1D26@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But whilst you're waiting, hardlink everything together, and 
> patch the differences (patch knows how to break hardlinks).

  I don't trust that approach -- too easy to screw up.

> Make a script that cp -lR's the tree to another copy (normally
> takes < 1s), and then remove the other arches. grep that.

  That could work for the reference tree.

> cscope with prebuilt indeces on a filtered subset of the files may well do
> better than grep, depending on exactly what you're doing (does 99% of it
> for me).

  Have you tried lxr?  The website is cool but you really need a local
copy for speed.

------
 Chuck
