Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbTCZQYv>; Wed, 26 Mar 2003 11:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbTCZQYv>; Wed, 26 Mar 2003 11:24:51 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:56993 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261762AbTCZQYt>; Wed, 26 Mar 2003 11:24:49 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF72A4868D.BBBD469B-ONC1256CF5.005A937E@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 26 Mar 2003 17:32:12 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/03/2003 17:33:46
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No.  Either we add Kerntypes to the architecture-independent code (I'm
all
> for it!) or not at all.  Cludging this into s390-specific code is a very,
> very bad idea.
Well, even if the Kerntypes gets added to the architecture-independent code
we still would need some special s390 includes to get all the types we need.
In particular the common i/o layer includes would have to be added in a
architecture specific way, either by #ifdef or by special files that get
include by the common kerntypes file.

blue skies,
   Martin


