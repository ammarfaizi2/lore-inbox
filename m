Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTDHUla (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTDHUla (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:41:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261767AbTDHUl3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:41:29 -0400
Subject: Re: KERNEL PROFILING
From: Andy Pfiffer <andyp@osdl.org>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
Cc: rddunlap@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kernelnewbies@nl.linux.org
In-Reply-To: <20030408130348.11e3946b.rddunlap@osdl.org>
References: <F20Lig41UjdSkleUBUh0001d797@hotmail.com>
	 <20030408130348.11e3946b.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049835184.2445.45.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Apr 2003 13:53:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> | 
> | Hi
> | If I use the command line option "profile=2" while booting the system, why 
> | /proc/profile file is not created? Should I have to create it manually?
> | 
> | Thanking You'
> | Shesha

You might want to double check your kernel command line after the system
has booted with "cat /proc/cmdline" and look for the "profile=2"
parameter.

% cat /proc/cmdline 
auto BOOT_IMAGE=linux-2.5.67 ro root=805 console=ttyS0,9600n8 profile=2
%

