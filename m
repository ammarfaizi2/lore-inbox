Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUDTXvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUDTXvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbUDTXvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:51:37 -0400
Received: from bay16-f72.bay16.hotmail.com ([65.54.186.122]:36880 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263843AbUDTXvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:51:35 -0400
X-Originating-IP: [69.40.24.195]
X-Originating-Email: [bobsmith401@hotmail.com]
From: "Bob Smith" <bobsmith401@hotmail.com>
To: pacneil@linuxgeek.net
Cc: suse-linux-e@suse.com, linux-kernel@vger.kernel.org
Subject: How to debug stripped binary or set kernel breakpoint (Was: HELP: Konqueror...)
Date: Tue, 20 Apr 2004 19:51:34 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F72biCnwhLqeb0001b3f1@hotmail.com>
X-OriginalArrivalTime: 20 Apr 2004 23:51:34.0810 (UTC) FILETIME=[69AE5FA0:01C42732]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: "Neil Schneider" <pacneil@linuxgeek.net>
>Reply-To: pacneil@linuxgeek.net
>To: suse-linux-e@suse.com
>Subject: Re: [SLE] HELP: Konqueror 3.2 hangs SuSE 2.4.21-202-smp4G in 'ps   
>    uax'
>Date: Sat, 17 Apr 2004 20:55:35 -0700 (PDT)
>
>First thing I would check is memory. Run memtest86 for several hours if
>any errors appear remove or replace the offending memory. Then look for
>other problems. Every time I've had this kind of unreproduceable random
>error it's been a bad memory module.

Thanks for the help.  I memtest86's overnight and came up with no errors on 
my one DIMM of Crucial Non-ECC, Non-parity PC2100 SDRAM (6464Z256).

Updating, strace shows a hang on a /proc/<pid>/stat read, as whown below.  
When run under strace, you can recover the terminal with Ctrl-C if and only 
if no strace log file is specified.

I'd like to use ps, or better yet vmstat as test tools, since they reliable 
freeze.  They are, unfortunately stripped binaries under SuSE 9.0.  Can 
anyone tell me if there's an easy way to get the symbols file(s) for these 
executable(s)?

Also, am I correct in thinking /boot/System.map will allow me to trace into 
the kernel?

TIA,
Bob

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.com/go/onm00200413ave/direct/01/

