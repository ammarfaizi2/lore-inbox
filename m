Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbUJ0Tyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbUJ0Tyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUJ0TuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:50:17 -0400
Received: from fms.tor.istop.com ([66.11.182.43]:4741 "EHLO
	maximus.fullmotions.com") by vger.kernel.org with ESMTP
	id S262546AbUJ0TsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:48:16 -0400
Subject: SSH and 2.6.9
From: Danny Brow <fms@istop.com>
To: Kernel-List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 15:59:58 -0400
Message-Id: <1098907198.2978.8.camel@hanzo.fullmotions.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this odd issue with the 2.6.9 & greater kernels, that I can't ssh
or use scp any more, this is what happens when I try:

SSH Error with-in X:
ssh_askpass: exec(/usr/libexec/ssh-askpass): No such file or directory
Host key verification failed.

SCP Error with-in X:
ssh_askpass: exec(/usr/libexec/ssh-askpass): No such file or directory
Host key verification failed.
lost connection

I just get Host key verification failed in the terminal with either
command.

ssh-askpass does not exsisit but it never has & ssh/scp works fine with
2.6.8.1 and below. When upgrading to the new kernel I just copied my
old .config and did a make oldconfig, make, etc.

Any ideas?

Thanks,
Dan.

