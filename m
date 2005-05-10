Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVEJPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVEJPco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEJPcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:32:43 -0400
Received: from smtp.e7even.com ([83.151.192.5]:38545 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261666AbVEJPcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:32:35 -0400
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: sean.mcgrath@propylon.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <4280CAEF.5060202@namesys.com>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com>  <1101287762.1267.41.camel@pear.st-and.ac.uk>
	 <1115717961.3711.56.camel@grape.st-and.ac.uk>
	 <4280CAEF.5060202@namesys.com>
Content-Type: text/plain
Message-Id: <1115739129.3711.117.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 May 2005 16:32:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 15:53, Hans Reiser wrote:
> I agree with the below in that sometimes you want to see a collection of
> stuff as one file, and sometimes you want to see it as a tree, and that
> file format browsers can be integrated into file system browsers to look
> seamless to users.
> 
> A quibble: A name is just a means to select a file; he is completely
> wrong to think that file browsers will eliminate filenames.

Yes, even if you think of the whole file system as a single "file", you
need a way to select the bit you need, and you will use names for that
(and whether you call that a filename, a file-part name or an object
name doesn't really matter).

It is interesting that both he and I gave the example of a book and
chapters, which is essentially a linear sequence, and the issue was just
the selection of a part of that sequence. It would also be interesting
to think about how you could map an arbitrary data structure more
complicated than a linear sequence (an "object") to disk. This brings up
issues of serialization and object databases....

