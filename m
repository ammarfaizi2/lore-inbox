Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTBCQHL>; Mon, 3 Feb 2003 11:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTBCQHL>; Mon, 3 Feb 2003 11:07:11 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:10184 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266736AbTBCQHK>; Mon, 3 Feb 2003 11:07:10 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 fixes (10/12).
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8CBA41C2.86FFFA68-ONC1256CC2.0058AD2A@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 3 Feb 2003 17:12:54 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/02/2003 17:15:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > updates for s390 scsi support
>
> Hmm, I can't find a single s390 scsi driver in the tree..

Yes, the description is a bit confusing. There is a scsi driver
for s/390 but it is not in the tree. But the fsf.h include file
is and this is part of the zfcp scsi driver. This include file
doesn't make sense on its own and the driver is still changing.
So it's best to remove the file. You could argue if this is an
update...

blue skies,
   Martin


