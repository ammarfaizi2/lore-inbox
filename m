Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSE3MRr>; Thu, 30 May 2002 08:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316607AbSE3MRq>; Thu, 30 May 2002 08:17:46 -0400
Received: from cm16094.red.mundo-r.com ([213.60.16.94]:52614 "EHLO demo.mitica")
	by vger.kernel.org with ESMTP id <S316606AbSE3MRp>;
	Thu, 30 May 2002 08:17:45 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH]: kernel-api.* compilation fix
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 30 May 2002 14:24:02 +0200
Message-ID: <m21ybtj02l.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        new dockbook utils are more picky about malformed SGML, I need
        that patch to get kernel-api.* to compile, notice that this
        really looks as the original intend.

diff -urN --exclude-from=/home/mitica/quintela/config/misc/dontdiff linux/Documentation/DocBook/kernel-api.tmpl linux-new/Documentation/DocBook/kernel-api.tmpl
--- linux/Documentation/DocBook/kernel-api.tmpl	2002-05-30 13:14:09.000000000 +0200
+++ linux-new/Documentation/DocBook/kernel-api.tmpl	2002-05-30 13:01:12.000000000 +0200
@@ -272,7 +272,7 @@
 !Edrivers/video/fbcmap.c
      </sect1>
      <sect1><title>Frame Buffer Generic Functions</title>
-!Idrivers/video/fbgen.c
+!Edrivers/video/fbgen.c
      </sect1>
      <sect1><title>Frame Buffer Video Mode Database</title>
 !Idrivers/video/modedb.c


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
