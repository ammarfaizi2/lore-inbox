Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVEISjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVEISjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVEISjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:39:09 -0400
Received: from mail.uni-ulm.de ([134.60.1.1]:20883 "EHLO mail.uni-ulm.de")
	by vger.kernel.org with ESMTP id S261480AbVEISjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:39:05 -0400
Date: Mon, 9 May 2005 20:40:22 +0200
From: Markus Klotzbuecher <mk@creamnet.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050509183135.GB27743@mary>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-DCC-sgs_public_dcc_server-Metrics: gemini 1199; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mini_fo is a virtual kernel filesystem that can make read-only file
systems writable. This is done by redirecting modifying operations to
a writeable location called "storage directory", and leaving the
original data in the "base directory" untouched. When reading, the
file system merges the modifed and original data so that only the
newest versions will appear. This occurs transparently to the user,
who can access the data like on any other read-write file system.

mini_fo was originally developed for use in embedded systems, and
therefore is lightweight in terms of module size (~50K), memory usage
and storage usage. Nevertheless it has proved usefull for other
projects such as live cds or for sandboxing and testing.

For more information and download of the sources visit the project
page:

http://www.denx.de/twiki/bin/view/Know/MiniFOHome

ChangeLog for mini_fo-0-6-0:
   - support for 2.4 and 2.6 kernels.
   - mini_fo now implements all file system operations.
   - many bugfixes and code cleanup.


Markus Klotzbuecher
