Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbSJJAWf>; Wed, 9 Oct 2002 20:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJJAWf>; Wed, 9 Oct 2002 20:22:35 -0400
Received: from mons.uio.no ([129.240.130.14]:57314 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263143AbSJJAWd>;
	Wed, 9 Oct 2002 20:22:33 -0400
To: Juan Gomez <juang@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Why NFS server does not pass lock requests via VFS lock() op?
References: <OFAB5FE3E3.3D571A56-ON87256C4D.008352AE@us.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Oct 2002 02:28:09 +0200
In-Reply-To: <OFAB5FE3E3.3D571A56-ON87256C4D.008352AE@us.ibm.com>
Message-ID: <shs8z1716jq.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > Oh ok. Well can we resuscitate this patch? The AFS NAS head
     > example is a good reason to do this.  If you need any help

If you do, make sure that you get the latest patch from Brian and
*NOT* the one that was in earlier versions of the -ac tree. The
latter screws lockd quite royally...

Cheers,
  Trond
