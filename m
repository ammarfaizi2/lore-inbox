Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWDDPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWDDPYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDDPYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:24:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22685 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750707AbWDDPYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:24:31 -0400
Date: Tue, 4 Apr 2006 16:24:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: regression in kbiuld with O=
Message-ID: <20060404152430.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make O=../test kernel/sched.o produces kernel/sched.o is source tree
now.  AFAICS, breakage started in 06300b21f4c79fd1578f4b7ca4b314fbab61a383
(kbuild: support building individual files for external modules).
