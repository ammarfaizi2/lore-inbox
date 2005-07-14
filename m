Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVGNTfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVGNTfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVGNTeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:34:04 -0400
Received: from web54405.mail.yahoo.com ([68.142.225.161]:18593 "HELO
	web54405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263077AbVGNTcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:32:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=o/u4qYpuQE4FPMRiY7L+ktNWwbv5h/LqgcSCJGHiz3VgmPfmTsCMvuS2Rc1b/slZo3qauEuw0/urc4nYwQfvsPkoj0vP3T9dzDQNKsVik7sU0Y7Po0zAOff3tjbaT8MBm59p3D9vCL2RbuyKrTTpdDrsnJ7zWeu2W2nv/LEiu+4=  ;
Message-ID: <20050714193211.29294.qmail@web54405.mail.yahoo.com>
Date: Thu, 14 Jul 2005 12:32:11 -0700 (PDT)
From: "Vlad C." <vladc6@yahoo.com>
Subject: Re: Linux On-Demand Network Access (LODNA)
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D46BF4.4000207@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Hans Reiser <reiser@namesys.com> wrote:
> You might look into SFS by David Mazieres, some
> concepts in it are
> likely to interest you.

Thank you for your suggestion. I've taken a look at
SFS (http://www.fs.net/sfswww/), and I like its
emphasis on user-friendliness and security. It's a
toss-up between SFS and SSHFS
(http://fuse.sourceforge.net/sshfs.html), since they
allow non-root users to mount and they're secure.

I tend to lean towards SSHFS since it only needs to be
installed on the client (as opposed to SFS, which must
be installed on client and server). The server side of
SSHFS is the just sshd, which has been heavily tested
and works out of the box on most modern systems. SFS
also has some minor idiosyncrasies, like mounting
everything under /sfs and including cryptographic
hashes as part of directory names (both of which can
be overcome with symlinks). 

Best regards,
Vlad


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
