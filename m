Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUHTIJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUHTIJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267698AbUHTIJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:09:01 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:54404 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S267620AbUHTIGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:06:55 -0400
Subject: SMP cpu deep sleep
From: Hans Kristian Rosbach <hk@isphuset.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1092989207.18275.14.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 10:06:47 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading through hotplug and speedstep patches
I came to think of a feature I think might be useful.

In an SMP system there are several cpus, this generates
extra heat and power consuption even on idle load.
Is there a way to put all cpus but cpu1 into a kind of
deep sleep? Cpu1 would have to do all work (including irqs)
of course.

We have a lot of SMP systems that we host, and they
are heavily used ~10 hours of the day, the rest they are
mostly idle. They could run on only 1 cpu during lenghty
idle periods.

If it is possible to put cpus to a deeper sleep than
just the simple idle, then the kernel could make use of this.

It would be a cool feature.

Sincerly
    Hans K. Rosbach


