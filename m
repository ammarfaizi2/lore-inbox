Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265136AbSJPACY>; Tue, 15 Oct 2002 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSJPACX>; Tue, 15 Oct 2002 20:02:23 -0400
Received: from pc132.utati.net ([216.143.22.132]:28068 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265136AbSJPACW>; Tue, 15 Oct 2002 20:02:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Set timestamp on symlink?
Date: Tue, 15 Oct 2002 15:06:04 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021016000940.B9E673A2@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can query a symlink's timestamp with lstat(2), but can't seem to set it.  
Attempting to set it with utime() twiddles the file it points to (which in 
this case is on a read-only partition).

Is there some kind of lutime(2) call I should be using?  Can't find a man 
page on it...

Rob
