Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSCQCt6>; Sat, 16 Mar 2002 21:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311263AbSCQCts>; Sat, 16 Mar 2002 21:49:48 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:10148 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311262AbSCQCti>; Sat, 16 Mar 2002 21:49:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        Adam Keys <akeys@post.cis.smu.edu>
Subject: Re: [BK] Having a hard time updating by pre-patch
Date: Sat, 16 Mar 2002 20:49:07 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there> <20020317031527.A31674@devcon.net>
In-Reply-To: <20020317031527.A31674@devcon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020317024932.UNAN1214.rwcrmhc54.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2002 08:15, Andreas Ferber wrote:
> If you have a clone of the full master 2.5 repository somewhere on
> your harddisk, you can go just there and do a
>
> % bk send -r1.158 - | bk receive /your/uml/repository
>
> After that change to your uml repository and do a
>
> % bk resolve
>
> to apply the 1.158 changeset to your uml repository (if you give a
> "-a" option to bk receive, bk resolve will be run automatically).

This looks like exactly what I need!  Except, the following is something I 
don't need:

bk: slib.c:11283: sccs_getInit: Assertion `e' failed.

I ran the bk send command exactly as above.  Is this a known bug?
-- 
akk~
