Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422884AbWBATTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWBATTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWBATTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:19:04 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:8652 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1422884AbWBATTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:19:02 -0500
Message-ID: <43E109BA.2070004@t-online.de>
Date: Wed, 01 Feb 2006 20:19:22 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] nfs version 2 broken
References: <43E05031.2000107@t-online.de>	 <1138774519.7861.4.camel@lade.trondhjem.org>  <43E0567F.20004@t-online.de>	 <1138775744.7875.0.camel@lade.trondhjem.org> <43E05FA1.6070407@t-online.de> <1138812065.7858.6.camel@lade.trondhjem.org>
In-Reply-To: <1138812065.7858.6.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Z6heYoZZZeHorMgVXf0jPthI3VwGcEN+V+2A6aybwHbnykwCdePrrs@t-dialin.net
X-TOI-MSGID: 93c1d3f0-b711-4bd0-870c-07dcce032375
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>Does it do the same if you mount the same partition normally (i.e. not
>through nfsroot) in some other directory?
>
>  
>

That also fails. Same error message.

Unlike the nfsroot code at least my version of mount
does not use nfs version 2 as the default. I had to force
a v2 nfs mount attempt with mount -o nfsvers=2 ...

Would it be a good idea to change the default nfs version
nfsroot uses? I think nfsroot and mount defaults should
be identical.

BTW: Google shows some related old threads, e.g. "Madhan" writes on
2 Aug. 2001 06:55  "There has been a change in the NFS Client
behaviour in Linux Kernel  2.4.3 onwards.  There are 2 issues here,
1. as traces show new clients expect link count '1' and NetWare
NFS has  been sending '0' for volumes. ..."

cu,
 Knut

