Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFOVxt>; Sat, 15 Jun 2002 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSFOVxs>; Sat, 15 Jun 2002 17:53:48 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:43277 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S315480AbSFOVxs>;
	Sat, 15 Jun 2002 17:53:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Reading bad blocks hangs with 2.4.19-pre10
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Jun 2002 23:53:48 +0200
Message-ID: <yw1x4rg4fbtf.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading a bad block on an IDE disk causes the system call to hang
instead of returning EIO. Example: running badblocks on a damaged
disk. 2.4.17 works correctly, 2.4.19-pre10 is broken, I don't know
about others. Is this a bug?

-- 
Måns Rullgård
mru@users.sf.net
