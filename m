Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRABUkS>; Tue, 2 Jan 2001 15:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131763AbRABUkJ>; Tue, 2 Jan 2001 15:40:09 -0500
Received: from raven.toyota.com ([63.87.74.200]:33030 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131717AbRABUkA>;
	Tue, 2 Jan 2001 15:40:00 -0500
Message-ID: <3A52357C.FCB7B187@toyota.com>
Date: Tue, 02 Jan 2001 12:09:32 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: LVM 0_9-1 woes on 2.4.0-prerelease+diffs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have 2 servers with lvm trouble, one running
Red Hat 6.2,  and the other running Red Hat 7.0
plus latest errata.

Both systems had been running lvm-0.8
on 2.4.0-test for awhile with no problems.

After instaling 2.4.0-prerelease and building
the lvm 0_9-1  source rpm on both systems,
I get the identical error on both systems:

# vgscan
vgscan: error while loading shared libraries: vgscan: undefined symbol:
lvm_remove_recursive

Except for lvm, all is running well.

Any clues?

Andrea? Heinz?

jjs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
