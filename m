Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbTAZXrt>; Sun, 26 Jan 2003 18:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbTAZXrt>; Sun, 26 Jan 2003 18:47:49 -0500
Received: from 203-79-122-66.cable.paradise.net.nz ([203.79.122.66]:33284 "EHLO
	ruru.local") by vger.kernel.org with ESMTP id <S267078AbTAZXrs>;
	Sun, 26 Jan 2003 18:47:48 -0500
Date: Mon, 27 Jan 2003 12:55:56 +1300
From: Volker Kuhlmann <list0570@paradise.net.nz>
To: linux-kernel@vger.kernel.org
Subject: isofs hardlink bug (inode numbers different)
Message-ID: <20030126235556.GA5560@paradise.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to back up directory trees on CD, preserving hard links.
newer versions of mkisofs are supposedly able to do this, but although
the data is written to the isofs only once, the resulting directory
entries have differing inode numbers thus making restore operations
impossible.

When I sent a bug report to the author of mkisofs, Jörg Schilling, I
got the reply

>>mkisofs 2.01a01 (i686-pc-linux-gnu)
>>mkisofs 2.0 (i686-pc-linux-gnu)
>>mkisofs 1.15a27 (i686-suse-linux)
>
>>Google shows no reference to anything which tells me that this is not
>>supposed to work, therefore I assume it's a bug.
>
>Nachdenken hilft wie in vielen Fällen auch hier:
>
>Der Bug auch hier ist da, wo es wegen schlechter SW Qualität wahrscheinlicher
>ist: Im Linux Kernel.

(Translation: thinking helps here too, like in many other cases: the bug
is in the linux kernel, where it is more likely to be due to lower
software quality.)

Insults aside, is it true that the kernel's isofs can't produce correct
inode numbers for hardlinked files? If that is the case it would
somewhat reduce the usefulness of isofs for backups.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

