Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFKCsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFKCsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 22:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFKCsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 22:48:11 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:55953 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263733AbUFKCsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 22:48:08 -0400
Message-ID: <40C91DA0.6060705@namesys.com>
Date: Thu, 10 Jun 2004 19:49:04 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de>
In-Reply-To: <20040610223532.GB3340@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>
>
>It appears to me that most developers agree to the two point above,
>but you have some problems with them, at least lately.  Am i wrong?
>
>Jörn
>
>  
>
I have a concept of stable version and development version.  V3 is the 
stable release branch, and should not be disturbed except for bug 
fixes.  V4 is where all new features go. 
In not very long, V4 will enter code freeze, and we will open a V5 
branch where all new features will go.

Filesystem users want conservative release management.  This is not 
gimp, this is a filesystem.  It must be a zero defect product or it is 
useless.

This is all part of what responsible release management is about.   I 
was the junior whiz kid in professional release management teams before 
starting Namesys.  I listened to my elders and learned from them.  My 
standards for professional conduct in this arena are higher than yours 
as a result of that. 

You are a bunch of young kids who lack professional experience in 
release management.  That is ok, but don't get aggressive about it.

I have no desire to pay for your mistakes, and as the official 
maintainer it is my responsibility to ensure that neither I nor the 
users pay for the mistakes of those who add bugs to stable branches 
instead of adding them to the development branches where they belong.

Hans
