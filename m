Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRLRLsi>; Tue, 18 Dec 2001 06:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280771AbRLRLsS>; Tue, 18 Dec 2001 06:48:18 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:41481
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S280725AbRLRLsF>; Tue, 18 Dec 2001 06:48:05 -0500
Subject: cpuid on SMP
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Dec 2001 12:46:35 +0100
Message-Id: <1008675995.13737.2.camel@twisti.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to try Dave Jones' x86info. It complained about missing
/dev/cpu/0/... So i inserted cpuid and started it again. Now it
complains about /dev/cpu/1/...

And there is no /dev/cpu/1/.

So, kernel is compiled with SMP, but cpuid is not working on both cpus.

Known bug?

Regards.

