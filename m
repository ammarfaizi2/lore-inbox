Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUFHPyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUFHPyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUFHPyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:54:50 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:47843 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S265236AbUFHPyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:54:41 -0400
Date: Tue, 8 Jun 2004 10:54:14 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: NFS and umount -f
Message-ID: <20040608155414.GA3975@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does this NOT do what is should be doing, i.e. umount no matter what?

Sometimes I get 

umount2 : Stale NFS file handle
umount : machine/path: Illegal seek

and it does not umount it.

What part of
 -f "Force unmount (in case of unreachable NFS system)" (umount man page)

does linux not understand?

shouldn't umount -f umount no matter what?

Andy

