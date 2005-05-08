Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVEHLSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVEHLSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 07:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVEHLSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 07:18:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54459 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262838AbVEHLSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 07:18:42 -0400
Date: Sun, 8 May 2005 13:18:40 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Subject: Re: [PATCH] Really *do* nothing in while loop
Message-ID: <20050508111840.GB12436@cip.informatik.uni-erlangen.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de> <427DE086.40307@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427DE086.40307@tls.msk.ru>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> >-		/* nothing */
> >+		/* nothing */;

> Well, the lack of semicolon is wrong really (and funny).

yes, it is but harmless in this envrionment.

> But is the whole while loop needed at all?  deflate()
> consumes as much input as it can, producing as much output
> as it can.  So without the loop, and without updating the
> buffer pointers ({next,avail}_{in,out}) it will do just
> fine without the loop, and will return something != Z_OK
> on next iteration.  If this is to mean to flush output,
> it should be deflate(&stream, Z_FLUSH) or something.

I have no idea.

> P.S.  What's git@vger.kernel.org for ?

It is the list which handles GIT related discussions. Frontend/backend
and isn't kernel related.

	Thomas
