Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTKSUxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 15:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTKSUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 15:53:35 -0500
Received: from mhub-w5.tc.umn.edu ([160.94.160.35]:6111 "EHLO
	mhub-w5.tc.umn.edu") by vger.kernel.org with ESMTP id S264063AbTKSUxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 15:53:34 -0500
Subject: Re: instructions of 2.6 README not working
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Ludootje <ludootje@linux.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1069271692.17900.4.camel@libranet>
References: <1069271692.17900.4.camel@libranet>
Content-Type: text/plain
Message-Id: <1069275206.8814.25.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 14:53:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 13:54, Ludootje wrote:
> Hi,
> I just download 2.6-test9 and line 122 of the README says "sudo make O=/home/name/build/kernel install_modules install".
> This doesn't work though (at least not here). I tried this:
> $ su
> # make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules
> # make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules_install
> and it worked. I suppose this is a mistake in the README... no?

No. This works with GNU Make 3.80. I suspect your version is older.

Matt

