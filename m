Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbULHOhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbULHOhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULHOhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:37:50 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:14915 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261220AbULHOht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:37:49 -0500
Date: Wed, 8 Dec 2004 14:37:37 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in fs/ext3/dir.c
In-Reply-To: <20041207201102.GA5177@think.thunk.org>
Message-ID: <Pine.LNX.4.58.0412081431000.3882@diagnostix.dwd.de>
References: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
 <20041207201102.GA5177@think.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Theodore Ts'o wrote:

> On Tue, Dec 07, 2004 at 09:56:26AM +0000, Holger Kiehl wrote:
> > [Sorry if you get this twice. This was send to ext3-users@redhat.com and
> >  the authors of ext3, but got no responce.]
> 
> I'm on ext3-users, but I didn't get the e-mail.....  so this is the
> first time I've seen this.
> 
> > When using readdir() on a directory with many files or long file names
> > it can happen that it returns the same file name twice. Attached is
> > a program that demonstrates this. 
> 
> Thanks for the test case, I'm currently looking at the problem....
> 
I see that Andrew Morton took out the relevant patch and that
Kris Karas reported some filesytem corruption. In my case it did NOT
corrupt the filesystem. I just checked it after some millions of files
went through the system for some days.

Holger
