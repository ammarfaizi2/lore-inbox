Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUBUEUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUBUERu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:17:50 -0500
Received: from hera.kernel.org ([63.209.29.2]:45238 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261534AbUBUEOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:14:18 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kernel too big
Date: Sat, 21 Feb 2004 04:14:13 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c16lul$g2b$1@terminus.zytor.com>
References: <UTC200402201400.i1KE0AH09811.aeb@smtp.cwi.nl> <403671FE.8090005@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077336853 16460 63.209.29.3 (21 Feb 2004 04:14:13 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 21 Feb 2004 04:14:13 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <403671FE.8090005@transmeta.com>
By author:    "H. Peter Anvin" <hpa@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Alternative I could take a stab at making these tables auto-generated
> and therefore completely eliminate this dependency for bzImage.
> 

Okay, I have a patch which makes this stuff generated fully dynamically:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/earlymem-1.diff

Andries, if you test this out and it works I'll submit it to akpm.

	-hpa
