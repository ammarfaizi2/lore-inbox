Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTKCMmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 07:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTKCMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 07:42:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64186 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261743AbTKCMmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 07:42:13 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16294.19747.640052.782753@laputa.namesys.com>
Date: Mon, 3 Nov 2003 15:42:11 +0300
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Hans Reiser <reiser@namesys.com>, Erik Andersen <andersen@codepoet.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
In-Reply-To: <20031031193016.GA1546@thunk.org>
References: <3F9F7F66.9060008@namesys.com>
	<20031029224230.GA32463@codepoet.org>
	<20031030015212.GD8689@thunk.org>
	<3FA0C631.6030905@namesys.com>
	<20031030174809.GA10209@thunk.org>
	<3FA16545.6070704@namesys.com>
	<20031030203146.GA10653@thunk.org>
	<3FA211D3.2020008@namesys.com>
	<20031031193016.GA1546@thunk.org>
X-Mailer: VM 7.17 under 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o writes:

[...]

 > 
 > I believe that there is a big difference between, "I want the file
 > named /home/tytso/src/e2fsprogs/e2fsck/e2fsck.c", and "I remember
 > vaguely that 5 years ago, I read a paper about the effects of high-fat
 > diets on akida's, where the first name of the author was Tom".  The
 > first is a filename lookup.  The second is a search.  I would like
 > better search tools for files in a filesystem, no doubt.  But I would
 > never, ever put a search that might return an ambiguous number of
 > responses (that might change over time as more files are added to the
 > filesystem) in a Makefile as a source file.  

It is called "a directory". :) There is no crime in putting

cc src/*.c

into Makefile. I think that Hans' query-result-object denoting multiple
objects is more like directory than single regular file.

[...]

 > 
 > 
 > 						- Ted

Nikita.
