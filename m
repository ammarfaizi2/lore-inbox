Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUFRAJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUFRAJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUFRAJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:09:21 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:46776 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264212AbUFRAJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:09:19 -0400
Message-ID: <40D232AD.4020708@opensound.com>
Date: Thu, 17 Jun 2004 17:09:17 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Stop the Linux kernel madness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I am writing this message to bring a huge problem to light. SuSE has been systematically
forking the linux kernel and shipping all kinds of modifications and still call their
kernels 2.6.5 (for example).

Either they ship the stock Linux kernel sources or they stop calling their distributions
as Linux-2.6.x based.

Kernel headers are being changed willy-nilly and SuSE are completely running rough-shod
over the linux kernel with the result ONLY software from SuSE works.

Enclosed is a simple diff between SuSE's so-called Linux 2.6.5-7.75-bigsmp
and the Linux 2.6.5 kernel sources from www.kernel.org:

Files linux-2.6.5/arch/i386/boot98/setup.S and linux-2.6.5-7.75/arch/i386/boot98/setup.S differ
Files linux-2.6.5/arch/i386/defconfig and linux-2.6.5-7.75/arch/i386/defconfig differ
Only in linux-2.6.5-7.75/arch/i386: defconfig.bigsmp
Only in linux-2.6.5-7.75/arch/i386: defconfig.debug
Only in linux-2.6.5-7.75/arch/i386: defconfig.default
Only in linux-2.6.5-7.75/arch/i386: defconfig.smp
Only in linux-2.6.5-7.75/arch/i386: defconfig.um

I would invite anybody to do a diff between the Linux 2.6.5 from kernel.org and
SuSE 9.1's Linux 2.6.5 kernels.

This is absolutely not our problem and we don't know who to contact at SuSE to fix
this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.

I think SuSE's lying when they call their Linux kernel a 2.6.5 kernel when there are
massive differences. They aren't even compatible with Linux 2.6.6.

I urge all those who have the power to sway distributions to immediately fix their
kernels so that small developers like us don't have to keep updating our software.
This is worse than Microsoft's practices.



best regards

Dev Mazumdar
President
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

