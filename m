Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUAPQ0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbUAPQ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:26:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:53945 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265631AbUAPQ0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:26:35 -0500
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item
	returned -28
From: Vladimir Saveliev <vs@namesys.com>
To: Valdis.Kletnieks@vt.edu
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <200401161620.i0GGK2MT022923@turing-police.cc.vt.edu>
References: <200401091622.41352.lkml@kcore.org>
	 <1074241063.2251.41.camel@tribesman.namesys.com>
	 <200401161620.i0GGK2MT022923@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1074270394.2251.167.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 16 Jan 2004 19:26:34 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-16 at 19:19, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 16 Jan 2004 11:17:43 +0300, Vladimir Saveliev said:
> 
> > This is just a warning. You should be able to free some disk space by
> > removing some files.
> 
> Is this just the *obvious* "removing files frees space", or is there some sort
> of garbage collection that will be triggered, so removing a 1K file will make it
> redo tables/linked lists/whatever and return lots of blocks that used to contain
> metadata?

This is the *obvious* "removing files frees space".

