Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVLESpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVLESpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVLESpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:45:45 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:30023 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751404AbVLESpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:45:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iEu1tOrO9Aux0lyH3qniJqc5uI/s7dTVAJsius8+BOPTF3OAg+7EARIAjklU678eLShYCCYacy7RN7lyiD5HskdV5Se9MaT0/1ltXEhUkhAnpobVcHwqW94RYIr756zQynC1vwiU3pceGi5Wsd8PnXBLfAdGrX0YyGeyZ3QHcCM=
Message-ID: <5bdc1c8b0512051045k213ef31di5693f166bcfee8a4@mail.gmail.com>
Date: Mon, 5 Dec 2005 10:45:43 -0800
From: Mark Knecht <markknecht@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rt22 - do_settimeofday() was called!
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I just built and booted 2.6.14-rt22. I noticed this message in dmesg:

do_settimeofday() was called!

   I have not followed all the discussions about timers (there have
been a lot!) but I do not remember seeing this with either -rt13 or
-rt21.

   Is it normal?

Thanks,
Mark
