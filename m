Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTE0JDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTE0JDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:03:45 -0400
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:4072 "EHLO
	d06lmsgate.uk.ibm.com") by vger.kernel.org with ESMTP
	id S262931AbTE0JDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:03:42 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Patch to add SysRq handling to 3270 console
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFDC120FDF.DF290EFE-ONC1256D33.002E7F84@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 27 May 2003 11:07:30 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/05/2003 11:08:27
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I considered the updates to be too late for 2.4.21.
>
> Too late and TOOO big.

Hmm, last time I sent patches it was 24380 lines. You can argue
about the dasd patch with 10647 lines which is big but the rest
is just architecture updates that have accumulated over time.
And its getting bigger if nothing ever gets integrated. And
ALL of it is s390 only code. I skipped the common code parts
which might have caused problems.

The patch I sent to Alan was a bit bigger since it included the
new tape driver as well (another 12000 lines) and had the latest
bug fixes as well.

Can we come up with a way to get the s390 stuff into some early
pre version of 2.4.22 in a way that I have to cut the patches only
once? It is very frustrating to spent hours doing patch-editing,
only to have them vanish into nowhere.

blue skies,
   Martin


