Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTHUBDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTHUBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:03:31 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29177 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262360AbTHUBDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:03:30 -0400
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200308201658.05433.habanero@us.ibm.com>
References: <200308201658.05433.habanero@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061427779.9371.318.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Aug 2003 18:02:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 14:58, Andrew Theurer wrote:
> Maybe this is already known, but just in case:  
> I cannot fully boot on an x440 system with 2.6.0-test3-bk8.  The kernel tries 
> to boot more than the 16 logical processors, and after failing (no response) 
> on cpus 16, 17, and 18, it still thinks it has 19 cpus total.  It finally 
> gets stuck at "checking TSC synchronization across 19 CPUs:"
> 
> Attached is the boot log.  Any ideas? I'll try -test3-bk7 next

Can you see if it works without HT on?  Did it work on plain -test3?  
My 16-way x440 with no HT boots fine on test3.

-- 
Dave Hansen
haveblue@us.ibm.com

