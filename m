Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUCNXjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCNXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:39:52 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:60777 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262059AbUCNXjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:39:51 -0500
Date: Sun, 14 Mar 2004 17:39:49 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: modules.inputmap empty?
Message-ID: <Pine.LNX.4.58.0403141734410.1800@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on reply.

For purely aesthetic reasons I decided to try compiling psmouse and pcspkr as
modules.  I've noticed that the most recent hotplug scripts don't find them and,
in fact, when I modprobe them manually I get a message about "no driver for
INPUT device <etc>".  That would be a question for the hotplug people, if it
were all; however, the reason it doesn't find any drivers is that there is
nothing in modules.inputmap.  It has the commented-out header and no modules
listed.  Why do these two modules not count as input drivers for depmod?

Kernel 2.6.4, module-init-tools-3.0.

-- 
Ryan Reich
ryanr@uchicago.edu
