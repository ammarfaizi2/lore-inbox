Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTIVAL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIVAL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:11:58 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:25613 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262651AbTIVAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:11:57 -0400
Subject: Re: [BUG][v2.6.0-test5] __ext3_journal_get_write_access<2>EXT3-fs
	error
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1063058883.908.6.camel@debian>
References: <1063058883.908.6.camel@debian>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1064189513.13147.23.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Sep 2003 02:11:55 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El mar, 09-09-2003 a las 00:08, Ramón Rey Vicente escribió:
> Hi
> 
> This happens deleting a big directory (~400 MiB) with many files and
> subdirs

I just try to reproduce this problem, but now with the htree support
disabled (without dir_index ext3 option) and the problem dissapears.
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

