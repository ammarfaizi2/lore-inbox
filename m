Return-Path: <linux-kernel-owner+w=401wt.eu-S1753529AbWLRIlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbWLRIlg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbWLRIlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:41:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:37822 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbWLRIlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:41:35 -0500
Date: Mon, 18 Dec 2006 08:41:33 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-rc3
Message-ID: <20061218084133.GA13867@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two changes before -final. The first one fixes a race where
one can hit a BUG(), the second one fixes CVE-2006-4814.

-final is just a few days ahead (it scares me, I'll have to check
my scripts to ensure everything's OK). If you have important fixes
you want to see in, or if it does not work for you, please
manifest yourself.

Willy

Summary of changes from v2.4.34-rc2 to v2.4.34-rc3
============================================

Hugh Dickins (1):
      zeromap may find a pte

Linus Torvalds (1):
      Fix incorrect user space access locking in mincore() (CVE-2006-4814)

Willy Tarreau (1):
      Change VERSION to 2.4.34-rc3

