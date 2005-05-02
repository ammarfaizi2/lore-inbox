Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEBMKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEBMKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEBMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:10:32 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59886 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261215AbVEBMK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:10:28 -0400
In-Reply-To: <20050502210411.06226103.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: andros@citi.umich.edu, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, matthew@wil.cx
MIME-Version: 1.0
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFE1EB7578.FC14251E-ONC1256FF5.003E40C6-C1256FF5.0042D17B@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Mon, 2 May 2005 14:10:20 +0200
X-MIMETrack: S/MIME Sign by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 02.05.2005 14:09:50,
	Serialize by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 02.05.2005 14:09:50,
	Serialize complete at 02.05.2005 14:09:50,
	S/MIME Sign failed at 02.05.2005 14:09:50: The cryptographic key was not
 found,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 02/05/2005 14:10:22,
	Serialize complete at 02/05/2005 14:10:22
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The intention of a read lease is to let the holder know is anyone tries 
to
> modify the file.
> 
> The current behaviour does not conflict with the man pages on Debian
> (although the previous behaviour did not either :-))

Now that I know what the intention of the read lease is, I agree that 
there
is no conflict :). Thanks for clarifying!

Heiko

