Return-Path: <linux-kernel-owner+w=401wt.eu-S1752061AbWLVTTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWLVTTF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLVTTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:19:05 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:61430 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061AbWLVTTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:19:04 -0500
Message-ID: <458C2FA1.3050402@lwfinger.net>
Date: Fri, 22 Dec 2006 13:18:57 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.20-rc1-git8 fails to build - another "clear_page_dirty' problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest git pull from Linus's git tree fails to build. The error message is

fs/built-in.o: In function `reiserfs_cut_from_item':
: undefined reference to `clear_page_dirty'
make: *** [.tmp_vmlinux1] Error 1

It seems that reiserfs needs to be updated to match the changes in dirty page handling.

Larry
