Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVG2Qfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVG2Qfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVG2Qdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:33:46 -0400
Received: from main.gmane.org ([80.91.229.2]:43750 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262653AbVG2QdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:33:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Fri, 29 Jul 2005 12:35:43 -0400
Message-ID: <42EA5ADF.9000202@tmr.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300428C952@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: acpi-devel@lists.sourceforge.net
X-Gmane-NNTP-Posting-Host: prgy-npn1.prodigy.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300428C952@hdsmsx401.amr.corp.intel.com>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
> I agree that the value of _LID can be usefult to user-space
> and I'll be sure it is restored as a property of the lid device
> under sysfs -- available as a simple file read like it
> was under /proc.

You're missing the point, removing the /proc feature breaks existing 
code. You can add new features in /sys as you like, but when you remove 
existing featires you break system for no benefit.

