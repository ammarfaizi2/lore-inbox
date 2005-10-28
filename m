Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVJ1HJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVJ1HJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVJ1HJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:09:50 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:56312 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965136AbVJ1HJt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:09:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sPaHrmnB5rB4YTSTYqcflJw4KrUOPdEsFY8eHZsOFPmNEnt7Q+qg+an9eoeC0pUA+sWkB2d9Y1ymD9kw2wS0fgKY+5b+Eug7AnXFwmMtvNEC39ImUJGdGAHl5BBu/MPfq2tg1DJ4P4GlmvRzydyzjUGRQ6PqUMuSndh6d46BGHY=
Message-ID: <9a9abfb40510280009v3f340f9dve02d6ffa110ae856@mail.gmail.com>
Date: Fri, 28 Oct 2005 12:39:48 +0530
From: Chaitanya Hazarey <c.v.hazarey@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why dependance of linux kernel on linux-kernel-headers package ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to know about some things regarding the current scheme of
things in the linux kernel compilation procedure on Debian machines.

Its a bicth  is that if I have to compile  specific modules against a
specific kernel version ( against  header files from that specific
version ).

The problem being that because of the kernel-headers package, the gcc
(in kernel make procedure) will pick up the kernel headers from the
package specific directories but not from the /usr/src/linux path
where my specific files reside.

The work-around though simple that to change the -I in the gcc path is
not simple as the frame-work is like very rigid about the headers path
in the linux kernel.


How do I make my kernel to take the kernel headers from an alternate
location. There should have been an alternate way to specify at a
single location the alternate configuration of the header file
location. But this does not seem to be the case.


Thanks,

Warm Regards,

Chaitanya V. Hazarey


ps:

Description of the linux-kernel-headers package

"Linux Kernel Headers for development

This package provides headers from the Linux kernel.  These headers
are used by the installed headers for GNU glibc and other system libraries."
