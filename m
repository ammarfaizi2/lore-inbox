Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUDZQv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDZQv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUDZQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:51:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10980 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263154AbUDZQvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:51:25 -0400
Date: Mon, 26 Apr 2004 09:51:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tom Armistead <tarmiste@eng.mcd.mot.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes to MVME5100 support in 2.6.5
Message-ID: <20040426165104.GC19246@smtp.west.cox.net>
References: <40880A0B.E9A569F5@eng.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40880A0B.E9A569F5@eng.mcd.mot.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:08:11AM -0700, Tom Armistead wrote:

> 
> This patch corrects problems of compiling and running the 2.6 kernel on
> the MVME5100 board.    The existing MVME5100 platform support in 2.6
> does not compile and run due to a moved include file (pplus.h) and a
> changed interface to openpic_init().  This patch corrects those
> problems.

Have you booted an MVME5100 after these changes as well?  The
mvme5100_openpic_initsenses table looks like it needs to be updated
still.  For a guide to how it should all look, if you've got the hw and
time, please look how the PowerPlus code was updated recently (in BK,
the key is trini@kernel.crashing.org|ChangeSet|20040311200618|42037,
currently changeset 1.1557.88.1).

-- 
Tom Rini
http://gate.crashing.org/~trini/
