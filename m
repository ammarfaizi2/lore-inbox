Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWD1UpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWD1UpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWD1UpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:45:10 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:28391 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1751380AbWD1UpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:45:08 -0400
Date: Fri, 28 Apr 2006 22:45:06 +0200
Message-Id: <1092993727@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: linux-kernel@vger.kernel.org
Subject: Linux I/O scheduling - ionice & co
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello experts!

Whenever I do large file operations on my VMware GSX Server (copying/backup operations on the HOST), all the VMs become dead slow, regardless what elevator i select at boot time.
 
what can I do that dedicated processes get higher preference regarding I/O ?
 
from this list i found, that in recent kernels we have cfq/ionice for this.
is this rated "stable" and does it already work well?
 
maybe there are alternative approaches for this?
 
let me give another example:
 
if i start an I/O hog like "dd if=/dev/zero of=test.dat" the whole interactivity of a linux system is being influenced very negatively. i have found that working on a system running an I/O hog often becomes a real pain.
if i start an CPU hog or syscall hog like "while true;do true;done" or "while /bin/true;do /bin/true;done" this never has such bad effects than starting an I/O hog.
 
is it possible to adress this by some more "fine-tuning" or is this just because of the "nature" of I/O scheduling ?
 
i would be happy if somebody could give a comment or share his experience about this.
 
TIA
roland k.
systems engineer
 
ps:
no comment about the behaviour of a windows system which is under high I/O load..... ;)
 
 
_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

