Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbSJATT5>; Tue, 1 Oct 2002 15:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSJATT4>; Tue, 1 Oct 2002 15:19:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53516 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261974AbSJATT4>; Tue, 1 Oct 2002 15:19:56 -0400
Date: Tue, 1 Oct 2002 20:25:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Al Viro <viro@math.psu.edu>,
       Andre Hedrick <andre@linux-ide.org>
Subject: sl82c105 and icside.c
Message-ID: <20021001202519.C5092@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can people stop patching these files for a while.

When Dalecki's stuff was ripped out, a set of important fixes were also
reverted in both of these drivers.  The end result is that my present
2.5.34 drivers are completely different from the 2.5.34 drivers in Linus'
tree.

I'd prefer these drivers to lag behind and I'll pick up the changes OR
copy me on the changes to these files please.  I don't mind which.

For the present, I've now got to work out exactly what changed between
.34 and .40 and apply those changes to some completely different versions
of these drivers.

Same goes for 2.4 as well unfortunately.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
