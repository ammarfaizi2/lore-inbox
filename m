Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUE1WUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUE1WUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUE1WRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:17:31 -0400
Received: from hera.kernel.org ([63.209.29.2]:33689 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264154AbUE1WQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:16:19 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: ftp.kernel.org
Date: Fri, 28 May 2004 22:15:20 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c98dlo$p7b$1@terminus.zytor.com>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528062141.GA18118@cox.net> <20040528150119.GE18449@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085782520 25836 127.0.0.1 (28 May 2004 22:15:20 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 28 May 2004 22:15:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040528150119.GE18449@thunk.org>
By author:    "Theodore Ts'o" <tytso@mit.edu>
In newsgroup: linux.dev.kernel
> 
> The main problem with rsync that I can see is that it is fairly heavy
> weight on the server, so many servers (including mirrors.kernel.org)
> have a maximum number of connections set to something pathetically
> small, like say 5 connections.  
> 

Eh?

mirrors.kernel.org currently allows 100 connections, this might be a
bit too low, but if so please let us know.

As far as *we can see* it's not a problem.

Disabling recursive listings in ftpd saved more CPU than rsync uses.

	-hpa
