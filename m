Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSL0KP2>; Fri, 27 Dec 2002 05:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSL0KP2>; Fri, 27 Dec 2002 05:15:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:56000 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263760AbSL0KP1>;
	Fri, 27 Dec 2002 05:15:27 -0500
Message-ID: <3E0C2A1F.ADAFC280@digeo.com>
Date: Fri, 27 Dec 2002 02:23:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Chua <jchua@fedex.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bdflush system call obsolete???
References: <Pine.LNX.4.51.0212271802520.664@boston.corp.fedex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2002 10:23:27.0446 (UTC) FILETIME=[FEADC760:01C2AD91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> 
> 2.5.53 kernel complaint about ...
> 
> warning: process 'update' used the obsolete bdflush system call.
> Fix your initscripts?
> 
> ... what's the replacement for "update-2.11"?
> 

There isn't one.  The daemon itself has been obsolete for years.

The parameters all changed, and the interface for setting those
is to read or write the entries in /proc/sys/vm/.  They are mostly
described in Documentation/sysctl/vm.txt.
