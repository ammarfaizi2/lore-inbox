Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUGUSm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUGUSm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbUGUSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:41:36 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:28121 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S266580AbUGUSkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:40:41 -0400
Message-ID: <40FEB8A5.6020601@blx4.net>
Date: Wed, 21 Jul 2004 14:40:37 -0400
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: 2.4.27rc2, DVD-RW support broke DVD-RAM writes 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.4.27rc2 (and I assume anything later than pre5 - that's when 
DVD-RW got added) DVD-RAMs have become read-only. Opening a DVD-RAM for 
writing results in "EROFS (Read-only file system)" (reported by 
'strace'. Let me know if I can provide any further info.
I'd be happy to test any fixes.

Also, any chance we get proper 'DVD-RAM is write-protected' support in 
2.4.x ? It'd be really nice if write()/open(O_WRONLY) would fail in 
those cases.

Tx,

Mathias
