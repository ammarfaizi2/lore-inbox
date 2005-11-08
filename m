Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVKHSP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVKHSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVKHSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:15:29 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:678 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965223AbVKHSP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:15:28 -0500
In-Reply-To: <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net>
Cc: "Al Viro" <viro@ftp.linux.org.uk>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 13:15:24 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I think it's just a syntax error...
>
>>> 	size = lseek(fd, 0, SEEK_SET);
>                              |___________  Whence at the end
>
> ... will do fine on three different systems so far.
>

Yeah I corrected that before trying but still didn't work on Debian  
(2.6.8 kernel)...
Running root, open successful but size is always zero - Strange..

Parag
