Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVDHHev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVDHHev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVDHHev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:34:51 -0400
Received: from adsl-212-101-16-178.solnet.ch ([212.101.16.178]:27761 "EHLO
	defiant.ds9.ch") by vger.kernel.org with ESMTP id S262723AbVDHHed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:34:33 -0400
Date: Fri, 8 Apr 2005 09:34:31 +0200
From: Marcel Lanz <marcel.lanz@ds9.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408073431.GA5463@ds9.ch>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

git on sarge

--- git-0.02/Makefile.orig      2005-04-07 23:06:19.000000000 +0200
+++ git-0.02/Makefile   2005-04-08 09:24:28.472672224 +0200
@@ -8,7 +8,7 @@ all: $(PROG)
 install: $(PROG)
        install $(PROG) $(HOME)/bin/
 
-LIBS= -lssl
+LIBS= -lssl -lz
 
 init-db: init-db.o
 
