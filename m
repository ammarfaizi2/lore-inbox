Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbTC0MIJ>; Thu, 27 Mar 2003 07:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbTC0MIJ>; Thu, 27 Mar 2003 07:08:09 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:18326 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261943AbTC0MII>; Thu, 27 Mar 2003 07:08:08 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF54A02ABC.0017054F-ONC1256CF6.004232A4@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 27 Mar 2003 13:17:14 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/03/2003 13:18:42
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now actually take a look at this diff :)  The biggest part is that the
> s390 compat files exist only on s390x and the math-emu dir only exists
> on s390, that's just a matter of conditionally compiling the files.

I did look at the diff. Did you? I generated the patch with diff -ur,
it does not contain the files which are special to s390 or s390x (like
the math-emu or the 31 bit compat layer). The patch is 5600 lines. A
small part of this diff can probably be avoided but you end up with
3000-4000 lines of real diff. Because of the size of this a merge of
s390 and s390x isn't simple and shouldn't be done in a hurry.

blue skies,
   Martin


