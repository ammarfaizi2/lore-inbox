Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267051AbUBSIxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267052AbUBSIxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:53:18 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:46078 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S267051AbUBSIxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:53:15 -0500
Subject: Re: sys_tux stolen @s390 in 2.6
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFA194181A.D3614558-ON41256E3F.002F56FC-41256E3F.0030CD22@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 19 Feb 2004 09:53:02 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 19/02/2004 09:53:07
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Hi Pete,

> in 2.4, syscall #222 was reserved for tux on s390, but now it is used
> by sys_readahead. What do we do now?

Did we? In my copy of 2.4 #222 is sys_readahead as well. I checked all
version of unistd in our cvs and there isn't a trace of sys_tux. It would
be really bad to have version of tux out there using a system call number
that is used for something different. Who reserved the number?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


