Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHOBIT>; Wed, 14 Aug 2002 21:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSHOBIT>; Wed, 14 Aug 2002 21:08:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47866 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316289AbSHOBIS>; Wed, 14 Aug 2002 21:08:18 -0400
Subject: Re: Will NFSv4 be accepted?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0208141435210.30333-100000@mooru.gurulabs.com>
References: <Pine.LNX.4.44.0208141435210.30333-100000@mooru.gurulabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:09:47 +0100
Message-Id: <1029373787.28240.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 21:49, Dax Kelson wrote:
> The fact that any janitor with a laptop (or any client with a malicious
> root user) can nuke all home directories from a standard NFS home
> directory server bothers me greatly.

Thats not an NFS2 or NFS3 issue, thats an implementation matter. A
proper NFS credential system prevents that from occurring. You also have
to fix some bogon assumptions in our NFS client too I grant. 

Alan (who is rapidly becoming an intermezzo freak instead)
