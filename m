Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFXKl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFXKl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:41:59 -0400
Received: from [62.75.136.201] ([62.75.136.201]:39063 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261852AbTFXKl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:41:57 -0400
Message-ID: <3EF82E3D.7030409@g-house.de>
Date: Tue, 24 Jun 2003 12:55:57 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: lord@sgi.com, owner-xfs@oss.sgi.com
Subject: module xfs: Relocation overflow vs section 9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i can't use XFS in 2.5.72 on linux Alpha, inserting the module gives:

kernel: module xfs: Relocation overflow vs section 9
modprobe: FATAL: Error inserting xfs
(/lib/modules/2.5.72/kernel/fs/xfs/xfs.ko): Invalid module format

in the log.

i've compiled with gcc3.3, other modules are ok. on ia32 XFS is fine, 
but not on this Alpha EV45 (Avanti). more info available, of course.

Thanks,
Christian.

