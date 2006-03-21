Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWCUVEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWCUVEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWCUVEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:04:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9402 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965120AbWCUVEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:04:34 -0500
Date: Tue, 21 Mar 2006 13:04:28 -0800
From: Paul Jackson <pj@sgi.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
Message-Id: <20060321130428.a221ed24.pj@sgi.com>
In-Reply-To: <442050C8.1020200@zytor.com>
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<dvn835$lvo$1@terminus.zytor.com>
	<Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
	<44203B86.5000003@zytor.com>
	<Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
	<442040CB.2020201@zytor.com>
	<Pine.LNX.4.61.0603211911090.2314@yvahk01.tjqt.qr>
	<44204BD9.1090103@zytor.com>
	<Pine.LNX.4.61.0603212005250.6840@yvahk01.tjqt.qr>
	<442050C8.1020200@zytor.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:
> Probably it would be worth trying to create "aux.h" under XP and see 
> what happens.  Unfortunately I don't have a 'doze system handy at the 
> moment.

On my windows xp box, I just ran the following three experiments,
all inside a window brought up by running Start->Run "cmd":
 
 C:\ copy con foo
 blah blah blah
 ^Z

 C:\ copy con aux
 blah blah blah

 C:\ copy con aux.h
 blah blah blah

The first experiment above created a file named 'foo',
containing 'blah blah blah'

The second and third experiments both returned to the
command prompt when I pressed "Enter" at the end of the
"blah blah blah", after first complaining:

   The system cannot find the file specified.
           0 file(s) copied.

This is on a fairly vanilla and uptodate Windows XP SP2.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
