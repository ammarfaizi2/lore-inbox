Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSGVEmP>; Mon, 22 Jul 2002 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSGVEmP>; Mon, 22 Jul 2002 00:42:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316106AbSGVEmO>;
	Mon, 22 Jul 2002 00:42:14 -0400
Message-ID: <3D3B8FBE.D5C11685@zip.com.au>
Date: Sun, 21 Jul 2002 21:53:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Heinz Diehl <hd@cavy.de>
CC: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [2.5.26] ext3 from Dec. 2001?
References: <20020720151600.GA268@chiara.cavy.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz Diehl wrote:
> 
> Hi!
> 
> Just a short question: is there a patch for 2.5.26 to update ext3 to
> ext3-0.9.18? There's still ext3-0.9.16 from Dec. 2001 present in 2.5.26.
> At ../people/sct on ftp.kernel.org there are only updates for kernel
> 2.2 and 2.4.

2.5 is uptodate wrt the current ext3-for-2.4 development tree.
That means that it's more uptodate than 2.4 is...

Some recent changes to ext3 have exposed a data=journal bug
in 2.5 which is also present in 2.4, but is much harder to hit
there.  I'm not sure what Stephen's intentions are on a 2.4
upgrade, but I'd be inclined to sit tight until 2.4.20-pre.

-
