Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTJNCXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTJNCXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:23:09 -0400
Received: from smtp13.eresmas.com ([62.81.235.113]:12521 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S262161AbTJNCXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 22:23:06 -0400
Message-ID: <3F8B5DDB.2050302@wanadoo.es>
Date: Tue, 14 Oct 2003 04:22:19 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] triple question marks in ppa.c
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel espetou:

> Don't ask me why???  Triple question marks are a C trigraph in ansi C.
                       ^^^^^^^^^^^^^^^^^^^^^

[1]'ISO/IEC 9899:1999  Programming languages  --  C' says in §5.2.1.1 that
C trigraph sequences are:

??=     #         ??)     ]         ??!     |
??(     [         ??'     ^         ??>     }
??/     \         ??<     {         ??-     ~

"No  other  trigraph  sequences exist", I didn't look [2] 'Corrigendum 1,
ISO/IEC 9899:1999/Cor 1:2001', but I think that they were not modified.

And inside of comments there are not trigraph substitutions, at least
in theory §6.4.9.

I only found a few in 2.4.22-bk30, aka 2.4.23-pre7:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106565695609164&w=2

thanks to fix them ;-)

[1]
  http://www.cl.cam.ac.uk/~mgk25/volatile/ISO-C-FDIS.1999-04.txt
  http://www.cl.cam.ac.uk/~mgk25/volatile/ISO-C-FDIS.1999-04.pdf
[2]
  http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=35952
-- 
Software is like sex, it's better when it's bug free.

