Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbRGQKaO>; Tue, 17 Jul 2001 06:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbRGQKaE>; Tue, 17 Jul 2001 06:30:04 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:17938 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S264990AbRGQK34>;
	Tue, 17 Jul 2001 06:29:56 -0400
Date: Tue, 17 Jul 2001 14:23:00 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
X-X-Sender: <ketil@ketil.np>
To: <linux-kernel@vger.kernel.org>
Subject: syncronous symlink()
Message-ID: <Pine.LNX.4.33.0107171400050.1817-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

How can I make be sure a symlink is on disk? In other words, I need to be
sure that both the symbolic link and the 'newpath' are on disk, so that
once the call has returned, I can pull out the plug of the computer and
not lose any data. Is it enough to sync() the directory to which the new
symlink was written?

Ketil

