Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUGKGcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUGKGcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 02:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUGKGcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 02:32:35 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35739 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S263100AbUGKGcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 02:32:35 -0400
To: Fawad Lateef <fawad_lateef@yahoo.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040711041925.98050.qmail@web20823.mail.yahoo.com>
Subject: Re: Need help in creating 8GB RAMDISK
From: Junio C Hamano <junkio@cox.net>
Date: Sat, 10 Jul 2004 23:32:32 -0700
Message-ID: <7vn027xddr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I understand correctly, earlier you said that you can use
your RAM into multiple ramdisks totalling 7GB or more, and the
only thing you are unable to do is to make it a single ramdisk.
If that is the case, I guess you should be able to kludge those
ramdisks together using raid0 or LVM.

