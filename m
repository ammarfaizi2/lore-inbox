Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbUJ0TqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbUJ0TqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUJ0Tmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:42:45 -0400
Received: from fms.tor.istop.com ([66.11.182.43]:4485 "EHLO
	maximus.fullmotions.com") by vger.kernel.org with ESMTP
	id S262594AbUJ0TkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:40:10 -0400
Subject: SSH and 2.6.9
From: Danny Brow <dan@fullmotions.com>
To: Kernel-List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 15:51:52 -0400
Message-Id: <1098906712.2972.7.camel@hanzo.fullmotions.com>
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

