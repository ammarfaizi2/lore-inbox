Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVDPUWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVDPUWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 16:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVDPUWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 16:22:09 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:63837 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262749AbVDPUWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 16:22:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LvD0nMz6y6iy/19ilALzHEZTEW2WNN/jmZW6sjzPxkFqxEJzTy4UhJ/U9EqJXGSEaVRUhpt3VaFq557bT8gYn5QmpzclcppXkn133DiZnePgYBogSyQb4b/OM5es+MP4o8vW1A6LnvshAGpnYfdxmsJ/51gvd/DgNOkmNaMo8qM=
Message-ID: <cc089fa0504161322326bcde6@mail.gmail.com>
Date: Sun, 17 Apr 2005 04:22:06 +0800
From: liscs 2005 <liscs2005@gmail.com>
Reply-To: liscs 2005 <liscs2005@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: when I write a script like NAT, how I can control the cpu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, everyone, 
 
Recently, I program a script like NAT, but I have no idea how to let it 
possess more cpu resource?
 
you know, in user space process is a small unit which possess the cpu 
and is controlled by schedule function.  but in kernel space, it seems 
not the same thing as it in user space, and NAT should not be viewed as 
a process, in turn I can not schedule it. 
 
I ought to alter my perspective to the driver like ? while , I 
realistically can not understand it.
 
Any help will be appreciated!
 
thanks , :)
