Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTESVnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTESVnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:43:03 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:1195 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S263011AbTESVnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:43:01 -0400
Message-ID: <3EC952E9.9080201@quark.didntduck.org>
Date: Mon, 19 May 2003 17:55:53 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Brian Gerst <bgerst@didntduck.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
References: <3EC82A7D.5090105@quark.didntduck.org> <20030519170226.GB983@mars.ravnborg.org>
In-Reply-To: <20030519170226.GB983@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, May 18, 2003 at 08:51:09PM -0400, Brian Gerst wrote:
> 
>>Convert foo-objs to newer-style foo-y.
> 
> 
> The paths looks correct.
> But do we really want to go that far, and deprecate the -objs syntax?
> 
> 
>>-adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
>>+adfs-y := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> 
> 
> The patch contains a lot of changes like the above - and they
> are only relevant if we deprecate the -objs syntax.
> 
> Opinions anyone?
> 
> 	Sam
> 

Why have two methods of doing the same thing?  foo-y is clearly the 
preferred method because it is easy to work with conditionals.

--
				Brian Gerst

