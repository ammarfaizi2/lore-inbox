Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUBCXkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUBCXkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:40:46 -0500
Received: from cfa.harvard.edu ([131.142.10.1]:46537 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S266199AbUBCXkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:40:45 -0500
Date: Tue, 3 Feb 2004 18:40:43 -0500 (EST)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: change kernel name
Message-ID: <Pine.SOL.4.58.0402031832060.1195@antu.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the following question:
If I compile the kernel (2.4.*) and boot it in, then the kernel-release,
as shown by 'uname -r' will be the string that was in the EXTRAVERSION
string from the kernel Makefile.
Is there any way to change this 'identity' of the kernel after the
compilation?
Such as
changekernelname bzImage "newname"

For example I have bzImage.test1, which I copy to bzImage.test2 (and not
complete recompile the kernel with new EXTRAVERSION string), and when
test1 boots in I would like uname to say 2.4.23-test1, and when test2
boots in to say 2.4.23-test2. And in addition to this, of course I copy
/lib/modules/2.4.23-test1 to /lib/modules/2.4.23-test2.

Cheers
Gaspar
