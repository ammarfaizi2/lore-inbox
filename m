Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTFJV5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFJV5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:57:08 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63368
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263949AbTFJV46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:56:58 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: root@chaos.analogic.com, Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Large files
Date: Tue, 10 Jun 2003 18:12:50 -0400
User-Agent: KMail/1.5
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0306100952560.4080@chaos> <20030610141759.GU28900@mea-ext.zmailer.org> <Pine.LNX.4.53.0306101057020.4326@chaos>
In-Reply-To: <Pine.LNX.4.53.0306101057020.4326@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101812.50632.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 June 2003 11:12, Richard B. Johnson wrote:
> On Tue, 10 Jun 2003, Matti Aarnio wrote:
> > On Tue, Jun 10, 2003 at 09:57:57AM -0400, Richard B. Johnson wrote:
> > > With 32 bit return values, ix86 Linux has a file-size limitation
> > > which is currently about 0x7fffffff. Unfortunately, instead of
> > > returning from a write() with a -1 and errno being set, so that
> > > a program can do something about it, write() executes a signal(25)
> > > which kills the task even if trapped. Is this one of those <expletive
> > > deleted> POSIX requirements or is somebody going to fix it?
> >
> >   http://www.sas.com/standards/large.file/

Is anybody indexing these suckers?  I've got a directory full of downloaded 
PDFs of things like the el-torito spec and bits of posix and sus, and I was 
just wondering if there's some kind of master list of all these things that 
Linux actually implements.

I suspect the answer is "probably not", but i thought I'd ask...

Rob

Rob
