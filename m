Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLXQcn>; Sun, 24 Dec 2000 11:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLXQce>; Sun, 24 Dec 2000 11:32:34 -0500
Received: from attila.bofh.it ([213.92.8.2]:18130 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S129406AbQLXQcS>;
	Sun, 24 Dec 2000 11:32:18 -0500
Date: Sun, 24 Dec 2000 17:00:53 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001224170052.A223@wonderland.linux.it>
In-Reply-To: <20001224092835.B649@wonderland.linux.it> <Pine.GSO.4.21.0012240330370.13109-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0012240330370.13109-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Dec 24, 2000 at 03:32:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 24, Alexander Viro <viro@math.psu.edu> wrote:

 >> I put "cp active active.ok" in the rc file before shutting down the
 >> daemon and at the next boot the files are different, every time.
 >
 >Could you send me both files? BTW, which filesystem it is?
I use ext2. The files are not corrupted, they just are not updated.
Another data point: at least in some cases, if I stop and start inn
without rebooting the files are the same.

--- active.ok   Sun Dec 24 09:58:00 2000
+++ active      Sun Dec 24 08:33:34 2000
@@ -1,5 +1,5 @@
 control 0000004793 0000004794 y
-control.cancel 0000022865 0000021934 n
+control.cancel 0000022864 0000021934 n
 junk 0000001806 0000001807 y
 fido.ita.ridere 0000014779 0000014777 y
 fido.ita.dewdney 0000004073 0000004074 y
@@ -10,19 +10,19 @@
 fido.ita.sf 0000004777 0000004778 y
 comp.os.linux.announce 0000010782 0000010779 m
 fido.ita.tex 0000000248 0000000249 y
-it.news.annunci 0000004909 0000004787 m
+it.news.annunci 0000004905 0000004787 m
 it.news.gestione 0000007878 0000007399 y
 fido.ita.tv 0000011944 0000011944 y
 it.test 0000000796 0000000797 y
-it.news.gruppi 0000048004 0000047898 y
+it.news.gruppi 0000047994 0000047898 y
 it.comp.sicurezza.varie 0000030696 0000030353 y
 it.comp.sicurezza.unix 0000002721 0000002722 y
-it.faq 0000001154 0000001091 m
+it.faq 0000001150 0000001091 m
[...]

-- 
ciao,
Marco

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
