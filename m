Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVBCAd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVBCAd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVBCAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:33:56 -0500
Received: from hera.kernel.org ([209.128.68.125]:55680 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262451AbVBCAdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:33:22 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Linux Kernel Subversion Howto
Date: Thu, 3 Feb 2005 00:29:00 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ctrr8c$4ho$1@terminus.zytor.com>
References: <20050202155403.GE3117@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107390540 4665 127.0.0.1 (3 Feb 2005 00:29:00 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 3 Feb 2005 00:29:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050202155403.GE3117@crusoe.alcove-fr>
By author:    Stelian Pop <stelian@popies.net>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> I've played lately a bit with Subversion and used it for managing
> the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
> bkcvs2svn conversion script.
> 
> Since there is little information on the web on how to properly
> set up a SVN repository and use it for tracking the latest kernel
> tree, I wrote a small howto (modeled after the bk kernel howto)
> in case it can be useful for other people too.
> 
> Feel free to comment on it (but let's not start a new BK flamewar
> or SVN bashing session please). If there is enough interest I'll
> submit a patch to include this in the kernel Documentation/ 
> directory.
> 
> I've put it also on my web page along with the necessary scripts:
> 	http://popies.net/svn-kernel/
> 
> And now a question to Larry and whoever else is involved in the
> bkcvs mirror on kernel.org: what is the periodicity of the CVS
> repository update ? 
> 

Currently it's nightly.  Larry has offered to run it more often if
someone can provide a dedicated fast machine to run it on.  (Larry: is
it a matter of memory or of CPU or both?  If nothing else we should
have the old kernel.org server, dual P3/1133 with 6 GB RAM, coming
free soon.)

Please let me know if there is something that should be put on
kernel.org; we can host repositories there of course.

	-hpa
