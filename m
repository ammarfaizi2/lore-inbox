Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263468AbTC2TBK>; Sat, 29 Mar 2003 14:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbTC2TBK>; Sat, 29 Mar 2003 14:01:10 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11539
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263468AbTC2TBJ>; Sat, 29 Mar 2003 14:01:09 -0500
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
From: Robert Love <rml@tech9.net>
To: john@grabjohn.com
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
References: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1048965146.9025.714.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2003 14:12:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 13:29, john@grabjohn.com wrote:

> Why not use
> 
> err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));
> 
> ?

The point of his cleanup is that you already know err is zero (look
again).

You also got it backward.

	Robert Love

