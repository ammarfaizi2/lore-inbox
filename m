Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWG1PZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWG1PZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWG1PZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:25:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:52940 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751986AbWG1PZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:25:06 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: linus' git tree not available ATM?
Date: Fri, 28 Jul 2006 17:24:53 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281724.54045.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since today, I get: 
~> git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
using git-1.4.1.1.

stracing it shows an empty answer from git-upload-pack request:

29312 socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
29312 connect(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("204.152.191.5")}, 16) = 0
29312 write(3, "0059git-upload-pack /pub/scm/linux/kernel/git/torvalds/linux-2.6.git\0host=git.kernel.org\0", 89) = 89
29312 read(3, "", 4)                    = 0
29312 write(2, "fatal: ", 7)            = 7
29312 write(2, "unexpected EOF", 14)    = 14

Any idea, what's wrong here?

Pete
