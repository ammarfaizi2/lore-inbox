Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbTAIJcs>; Thu, 9 Jan 2003 04:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTAIJcs>; Thu, 9 Jan 2003 04:32:48 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:39177 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262395AbTAIJcs>; Thu, 9 Jan 2003 04:32:48 -0500
Message-ID: <3E1D43EF.F74B8AC8@aitel.hist.no>
Date: Thu, 09 Jan 2003 10:42:07 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
References: <200301081057.h08Av1og000585@darkstar.example.net> <200301082133.h08LXlRA014406@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> $ DIR FOO.TXT;*
> FOO.TXT;1   FOO.TXT;2   FOO.TXT;2
> 
> VMS-style file versioning, anybody? ;)

This certainly lets you recover old overwritten files,
but VMS didn't protect against a "rm *".  It'd
delete all revisions in one go.

Helge Hafting
