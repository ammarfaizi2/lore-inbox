Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUFPLts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUFPLts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUFPLtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:49:47 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:53207 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266249AbUFPLtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:49:46 -0400
Message-ID: <40D033C9.9040100@t-online.de>
Date: Wed, 16 Jun 2004 13:49:29 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geoff Mishkin <gmishkin@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ld segfault at end of 2.6.6 compile
References: <1087385018.8669.36.camel@amsa>
In-Reply-To: <1087385018.8669.36.camel@amsa>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: JbTQumZrQeRGOYPnED0llNWLqFfsj4cyHiHFP1JTEYIX9k4BSmcpoV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Mishkin wrote:
> I tried it again with linux-2.6.7-rc3, but got the same error.
> 
> My glibc version is 2.3.3.20040420.  The kernel still compiles fine on
> my other machine.  I also compiled on the nonworking machine with the
> same .config as the working one, and still got the same problem.
> 
Maybe you are simply running out of memory at link time. You
could use 'top -d 1' on another terminal to watch memory
consumption while the linker is running.


Regards

Harri
