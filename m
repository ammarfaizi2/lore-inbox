Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSJOQyc>; Tue, 15 Oct 2002 12:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSJOQy2>; Tue, 15 Oct 2002 12:54:28 -0400
Received: from web13801.mail.yahoo.com ([216.136.175.11]:27723 "HELO
	web13801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263321AbSJOQxx>; Tue, 15 Oct 2002 12:53:53 -0400
Message-ID: <20021015165947.50642.qmail@web13801.mail.yahoo.com>
Date: Tue, 15 Oct 2002 09:59:47 -0700 (PDT)
From: Padraig O Mathuna <padraigo@yahoo.com>
Subject: mapping 36 bit physical addresses into 32 bit virtual
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm developing some drivers for the AU1000 under
Mountain Vista's 2.4.17 sherman release. The AU1000 is
a MIPS based SOC with a 36 bit internal address bus
and a 32 bit MIPS cpu.  According to the documentation
the MIPS' TLB is able to map 32 bit virtual addresses
to 36 bit physical addresses, however I cannot figure
out how to get Linux to set this up.  I've looked at
ioremap which only takes unsigned long (32bits) as an
argument to assign a virtual address.  Is there
another way?

thanks

Padraig

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
