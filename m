Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbTJNIlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJNIlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:41:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:65511 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262243AbTJNIk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:40:58 -0400
Message-ID: <3F8BB699.3070404@namesys.com>
Date: Tue, 14 Oct 2003 12:40:57 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       vs@thebsh.namesys.com, jw schultz <jw@pegasys.ws>,
       Alex Adriaanse <alex_a@caltech.edu>
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <2003Oct14.085717@a0.complang.tuwien.ac.at>
In-Reply-To: <2003Oct14.085717@a0.complang.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked again at the definition of the difference between ctime and 
mtime on the stat man page, and I think that updating ctime in response 
to rename is as reasonable as updating it in response to changing the 
number of links.

Ok, we will conform, and I will accept the kindly donated patch, along 
with Andrew's optimization of our evaluation of CURRENT_TIME.  vs, 
please add Andrew's suggested optimization and sent the result through 
QA.  Thanks to all for your good advice.

-- 
Hans


