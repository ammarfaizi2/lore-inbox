Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSJHXqt>; Tue, 8 Oct 2002 19:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbSJHXpc>; Tue, 8 Oct 2002 19:45:32 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37852 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261401AbSJHXor>;
	Tue, 8 Oct 2002 19:44:47 -0400
Date: Wed, 9 Oct 2002 00:52:52 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug 2 cpus shows as 4 cpus
Message-ID: <20021008235252.GA22321@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Chua <jchua@fedex.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 07:39:37AM +0800, Jeff Chua wrote:
 > 
 > I'm running 2.4.20-pre9 on DELL server with Xeon dual processors, but
 > /proc/cpuinfo shows not 2, but "4" cpus!
 > The bogomips semms to indicate 2 cpus. (3971.48 is about 2GHz x 2).
 > Is this problem related to Xeon? I've other SMP boxes with P3, but they
 > reports correctly 2 cpus.

P4 xeon has hyperthreading.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
