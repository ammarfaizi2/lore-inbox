Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUB2X7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUB2X7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:59:34 -0500
Received: from main.gmane.org ([80.91.224.249]:12985 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262189AbUB2X7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:59:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Is the 2.6 dependency information complete? Doesn't look so...
Date: Mon, 01 Mar 2004 00:59:30 +0100
Message-ID: <yw1xeksd1lp9.fsf@kth.se>
References: <20040229235150.GA6327@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:xbPlY0B3KCI1CBbcbV5pwYP1t48=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> Hi,
>
> I've just seen, after a BK pull:
>
>   CC      fs/nfsd/nfsctl.o
> fs/nfsd/nfsctl.c:28:30: linux/nfsd_idmap.h: no such file or directory
>
> This is a hint the dependency information isn't complete, otherwise, GNU
> make would've "get"^Wgot the include file.

That's right.  Running bk -r get before building is advisable.

-- 
Måns Rullgård
mru@kth.se

