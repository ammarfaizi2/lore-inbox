Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFGAV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFGAV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:21:56 -0400
Received: from dp.samba.org ([66.70.73.150]:28827 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262409AbTFGAVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:21:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.12932.161268.783738@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 10:32:04 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>
References: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com>
	<Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> You can get check from
> 
> 	bk://kernel.bkbits.net/torvalds/sparse

Is that up to date?  I cloned that repository and said "make" and got
heaps of compile errors.  First there were a heap of warnings like
this:

symbol.h:73: warning: declaration does not declare anything

and then lots of errors like this:

parse.c:44: error: structure has no member named `ctype'

and indeed the structures defined in the headers don't seem to match
up with their uses in the .c files.

Paul.
