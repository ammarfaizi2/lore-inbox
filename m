Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132741AbRDUQjX>; Sat, 21 Apr 2001 12:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132742AbRDUQjM>; Sat, 21 Apr 2001 12:39:12 -0400
Received: from tangens.hometree.net ([212.34.181.34]:52696 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132741AbRDUQjB>; Sat, 21 Apr 2001 12:39:01 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@mail.hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Request for comment -- a better attribution system
Date: Sat, 21 Apr 2001 16:38:59 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9bsd33$peb$1@forge.intermeta.de>
In-Reply-To: <20010421114942.A26415@thyrsus.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 987871139 27449 212.34.181.4 (21 Apr 2001 16:38:59 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 21 Apr 2001 16:38:59 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

>Here is an example map block for my kxref.py tool:

># %Map
># T: CONFIG_ namespace cross-reference generator/analyzer
># P: Eric S. Raymond <esr@thyrsus.com>
># M: esr@thyrsus.com
># L: kbuild-devel@kbuild.sourceforge.net
># W: http://www.tuxedo.org/~esr/cml2
># D: Sat Apr 21 11:41:52 EDT 2001
># S: Maintained

>Comments are solicited.

Hi Eric,

please not. If you really want to redo this, please use a simple XML
markup.  Let's not introduce another kind of markup if there is
already a well distributed and working.

What's wrong with:

<MAP NAME="CONFIG_ namespace cross-reference generator/analyzer"
     URL="http://www.tuxedo.org/~esr/cml2"
     STATUS="Maintained"
     DATE="Sat Apr 21 11:41:52 EDT 2001">
 <MAINTAINER NAME="Eric S. Raymond"
             MAIL="esr@thyrsus.com"/>
 <PATCHES DESC="Send all patches here."
          MAIL="esr@thyrsus.com" />
 <LIST MAIL="kbuild-devel@kbuild.sourceforge.net"
       DESC="List for developers"/>
 <LIST MAIL="kbuild-user@kbuild.sourceforge.net"
       DESC="List for users"/>
</MAP>

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
