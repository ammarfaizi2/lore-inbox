Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUAaNZh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 08:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUAaNZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 08:25:37 -0500
Received: from main.gmane.org ([80.91.224.249]:26337 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264575AbUAaNZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 08:25:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Software Suspend 2.0
Date: Sat, 31 Jan 2004 14:25:33 +0100
Message-ID: <yw1xznc4tfle.fsf@kth.se>
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com>
 <1075531042.18161.35.camel@laptop-linux>
 <20040131064757.GB7245@digitasaru.net>
 <1075532166.17727.41.camel@laptop-linux>
 <20040131071619.GD7245@digitasaru.net>
 <1075534088.18161.61.camel@laptop-linux>
 <20040131073848.GE7245@digitasaru.net>
 <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de>
 <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de>
 <1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Gmane-NNTP-Posting-Host: ti200710a080-2939.bb.online.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:FEB4m6emdCl6GZ3xGM8VmbzglVU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> writes:

>> My error. My patch script has put kernel/power/swsusp2.c in the version
>
> No problem. I already tested it. After throwing out usb modules, it
> did suspend, though taking quite long at the kernel and processing
> (something like that) message. But upon restart, it didn't resume,
> ie. it didn't find its image, just normal swap space.

Try disabling write cache on the disk with hdparm -W0 /dev/hde.

-- 
Måns Rullgård
mru@kth.se

