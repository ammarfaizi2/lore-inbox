Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTIGWAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTIGWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:00:43 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:5389 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261684AbTIGWAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:00:41 -0400
Date: Sun, 7 Sep 2003 14:59:53 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] bk chmod needed for scripts/*
Message-ID: <20030907215953.GA11020@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	The various executables in the scripts/ directory are marked 644 in
BK.

	Can do you do:
bk chmod 755 \
    `find scripts -type f -exec file {} \;|egrep -v ELF|egrep exec|cut -f1 -d:`

for the scripts/* stuff?

Thanks,

-- DN
Daniel
