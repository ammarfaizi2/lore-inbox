Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276503AbRJKPLa>; Thu, 11 Oct 2001 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276381AbRJKPLU>; Thu, 11 Oct 2001 11:11:20 -0400
Received: from web20508.mail.yahoo.com ([216.136.226.143]:17417 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276503AbRJKPLL>; Thu, 11 Oct 2001 11:11:11 -0400
Message-ID: <20011011151045.40155.qmail@web20508.mail.yahoo.com>
Date: Thu, 11 Oct 2001 17:10:45 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux-2.4.10-ac11
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011080046.C12016@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erm, these files should include <linux/pm.h>
directly and not
> expect something else to pull it in.  Doing a quick
grep
> shows that everything else does.

well, I find it normal that a file which uses some
definitions
includes the required files itself. Else, a single
change in any
".h" file would have repercussions on many files and
external
projects.

Willy


___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
