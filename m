Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTLFBgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTLFBgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:36:10 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:59289 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264918AbTLFBgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:36:07 -0500
Subject: Re: partially encrypted filesystem
From: Pat LaVarre <p.lavarre@ieee.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>
In-Reply-To: <Pine.LNX.4.44.0312060112450.11626-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0312060112450.11626-100000@gaia.cela.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1070674555.2939.35.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Dec 2003 18:35:55 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2003 01:36:06.0619 (UTC) FILETIME=[5160BAB0:01C3BB99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are pushing this down to the file system.  I'd venture too say that 
> this will majorly stress the fs code, make its indexing slower and 
> majorly fragment the file on disk (if it's later overwritten).  Sure - you 
> have less work to do (less to code) - but the end effect might be 
> painful, especially on often written files (if the file ain't written to 
> then there are much better compression solutions).

Suppose we wish to encrypt the files on a disc or disk or drive that we
carry from one computer to another.

Where else can the encryption go, if not "down to the file system"?

Pat LaVarre


