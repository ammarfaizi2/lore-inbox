Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbVIVQi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVIVQi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbVIVQi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:38:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:35228 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030439AbVIVQi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:38:58 -0400
Subject: Libata for parallel ATA controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 18:05:26 +0100
Message-Id: <1127408726.18840.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I mentioned a while ago I was hacking on libata and PATA drivers. I've
also fed a few bits of the needed support code to Jeff Garzik as I went.

Some initial patches are now ready for wider testing although strictly
suicide squad material at this point. I'm now at the point I'm running a
full Fedora Core 4 with CONFIG_IDE=n using four disk raid on SIL680
controllers.

A lot of hardware isn't yet covered - I'm working on adding more support
but I wanted to start with weirder devices first to better understand
what was needed in libata.

Status info and patches are at

http://zeniv.linux.org.uk/~alan/IDE


Enjoy but remember this is very early code and don't use it for
production!

