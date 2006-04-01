Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWDAVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWDAVFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWDAVFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 16:05:49 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:3583 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932239AbWDAVFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 16:05:48 -0500
X-ASG-Debug-ID: 1143925546-24218-4-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Remove unused exports and save 98Kb of kernel size
Subject: Remove unused exports and save 98Kb of kernel size
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 01 Apr 2006 23:05:45 +0200
Message-Id: <1143925545.3076.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10357
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
kernel; it's too big for the list so it can be found at

http://www.kernelmorons.org/unexport.patch

-rwxr-xr-x 1 root root 34476416 Apr  1 21:59 vmlinux.before
-rwxr-xr-x 1 root root 34378112 Apr  1 22:48 vmlinux.after

As you can see this saves 98Kb kernel size... that's not peanuts.

Signed-off-by: Arjan van de Ven <arjan@kernelmorons.org>




