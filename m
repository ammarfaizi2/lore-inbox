Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272424AbTGaGbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272443AbTGaGa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:30:59 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25009
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272424AbTGaG35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:29:57 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: David Howells <dhowells@warthog.cambridge.redhat.com>,
       "Charles P. Wright" <cpwright@cpwright.com>
Subject: Re: [PATCH] General filesystem cache
Date: Thu, 31 Jul 2003 02:31:54 -0400
User-Agent: KMail/1.5
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <17869.1058693883@warthog.warthog>
In-Reply-To: <17869.1058693883@warthog.warthog>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307310231.54435.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 July 2003 05:38, David Howells wrote:
> > Is this patch available from somewhere?  I looked on the MARC archives
> > but haven't been able to find the original mail which includes the patch.
>
> I don't know. The message containing the patches doesn't seem to have made
> it into either the LKML or the linux-fsdevel mailing lists.
>
> The basic code can be found in:
>
> 	http://cvs.infradead.org/cgi-bin/cvsweb.cgi/afs/
>
> In directories:
>
> 	Documentations/filesystems/
> 	include/linux/
> 	fs/cachefs/
>
> I'll see about putting the patch up for download when I get to OLS.
>
> David

Random question:

Way back when I used union mount code (under OS/2) that would mount the first 
filesystem read-only, and allow you to cache changes to it in a second 
filesystem.  (So you could do a build of slightly self-modifying code, a lot 
like the Linux build in 2.4 was, against a read-only tree.) 

Would this be a good tool for that sort of application?  (There's all sorts of 
other "trial run" type applications; running stuff against database snapshots 
and then seeing what the deltas are, etc...)

Rob

