Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFTKXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFTKXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFTKXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:23:09 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:58055 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261306AbVFTKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:20:33 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12] XFS: Undeletable directory
Date: Mon, 20 Jun 2005 12:20:20 +0200
User-Agent: KMail/1.8.1
Cc: Valdis.Kletnieks@vt.edu, Edwin Eefting <psy@datux.nl>,
       linux-xfs@oss.sgi.com
References: <200506191904.49639.lkml@kcore.org> <200506192034.18690.lkml@kcore.org> <200506192302.j5JN2M5P009849@turing-police.cc.vt.edu>
In-Reply-To: <200506192302.j5JN2M5P009849@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201220.20703.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 01:02, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 19 Jun 2005 20:34:18 +0200, Jan De Luyck said:
> > On Sunday 19 June 2005 21:25, Edwin Eefting wrote:
> > > ls -la 4207214/ also shows nothing?
> >
> > Nothing out of the ordinary:
> >
> > devilkin@precious:/lost+found$ ls -la 4207214/
> > total 8
> > drwxrwxrwx  2 root root 8192 Jun 19  2005 .
> > drwxr-xr-x  3 root root   20 Jun 19  2005 ..
>
> Might want to do 'ls -lai' to get the inode numbers for . and .. and
> then go sanity check them ('.' should have the same inode number as
> lost+found/4207214, and '..' should have the same inode number as
> lost+found)

The inode numbers are correct.

Jan

-- 
If the very old will remember, the very young will listen.
		-- Chief Dan George
