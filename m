Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSGJIRa>; Wed, 10 Jul 2002 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGJIR3>; Wed, 10 Jul 2002 04:17:29 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24324 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316961AbSGJIR2>; Wed, 10 Jul 2002 04:17:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Vitaly Fertman <vitaly@namesys.com>
To: reiserfs-list@namesys.com
Subject: reiserfsprogs release
Date: Wed, 10 Jul 2002 12:06:48 +0400
X-Mailer: KMail [version 1.4]
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com>
In-Reply-To: <200206261317.10813.vitaly@namesys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207101206.48370.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

the latest reiserfsprogs-3.6.2 is available on our ftp site.

The most of changes are just bug fixes and speedups.
    StatData got wrong values sometimes.
    Tails were not converted back if had been converted to internal.
    Lost+found was not accessible sometimes due to wrong flag in
    metadata.
    Extra checks on --check and fixes on --fix-fixable were added
    for wrong st_nlinks, some info in internal tree.
    Some multiple checks during overwriting and relocation were
    eliminated.
    Etc.

Added different block size support - 1k, 2k and for Alpha 8k.
Kernel support we are going to include into 2.4.20.

Support for bad block lists was added also but disabled for now
due to some conflicts with the current kernel, which have not been
solved yet.

Verson numbering scheme was changed.

Another pre release 3.6.3-pre1 is also available. It includes some 
great speedups for reiserfsck.

-- 

Thanks,
Vitaly Fertman
