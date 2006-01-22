Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWAVMwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWAVMwH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWAVMwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:52:07 -0500
Received: from relay4.usu.ru ([194.226.235.39]:22475 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S964780AbWAVMwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:52:04 -0500
Message-ID: <43D37FEF.9070603@ums.usu.ru>
Date: Sun, 22 Jan 2006 17:51:59 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [OT] Re: [2.6 patch] the scheduled removal of the obsolete raw driver
References: <20060119030251.GG19398@stusta.de> <20060118194103.5c569040.akpm@osdl.org> <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com> <20060119165832.GS19398@stusta.de>
In-Reply-To: <20060119165832.GS19398@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.148; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> The oflag=direct option was added to GNU coreutils in version 5.3.0.

5.3.0 is "beta", 5.93 is "stable". But there is one thing that won't let 
you use newer Coreutils: LSB, namely the Li18nux2000 tests. Coreutils is 
one of those packages that never go to distros in their pristine form. 
And, alas, there is still no working patch against Coreutils-5.93 that 
allows passing the LSB testsuite completely. And distromakers won't 
trade bugs tested in LSB for bugs unknown to LSB but fixed upstream. So, 
users are really screwed.

-- 
Alexander E. Patrakov
