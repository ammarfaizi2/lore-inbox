Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273294AbRIQBQP>; Sun, 16 Sep 2001 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273303AbRIQBQF>; Sun, 16 Sep 2001 21:16:05 -0400
Received: from zok.SGI.COM ([204.94.215.101]:28864 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273294AbRIQBPv>;
	Sun, 16 Sep 2001 21:15:51 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10-pre10 
In-Reply-To: Your message of "Sun, 16 Sep 2001 15:00:17 MST."
             <Pine.LNX.4.33.0109161454090.3392-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Sep 2001 11:15:13 +1000
Message-ID: <492.1000689313@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10-pre10 still contains drivers/scsi/53c700-mem.c.  This is a
generated file and should not be shipped, it messes up separate source
and object builds.  Please delete 53c700-mem.c and add it to the don't
diff list.

