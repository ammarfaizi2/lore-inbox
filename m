Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUJZL4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUJZL4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUJZL4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:56:23 -0400
Received: from a.mx.polytechnique.org ([129.104.30.34]:38854 "EHLO
	a.mx.polytechnique.org") by vger.kernel.org with ESMTP
	id S262239AbUJZL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:56:20 -0400
Message-ID: <417E3B62.1000701@bellard.org>
Date: Tue, 26 Oct 2004 13:56:18 +0200
From: Fabrice Bellard <lkml@bellard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCCBOOT: compile and boot Linux with TinyCC
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just to announce that it is now possible to compile and start booting 
Linux with the TCCBOOT boot loader 
(http://bellard.org/tcc/tccboot.html). It takes less than 15 seconds on 
a 2.4 GHz Pentium 4 to compile and boot Linux :-)

TCCBOOT contains the latest release of the TinyCC C compiler, assembler 
and linker, which is able to compile most of the Linux kernel with only 
tiny patches. Of course there are still a few bugs in the generated 
kernel, and the code quality is far from the one of GCC, but it shows 
what it is possible to do with a 110 KB C compiler !

Fabrice.
