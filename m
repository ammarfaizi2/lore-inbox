Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291222AbSBHAZj>; Thu, 7 Feb 2002 19:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291224AbSBHAZa>; Thu, 7 Feb 2002 19:25:30 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:36776 "EHLO jhuml3.jhu.edu")
	by vger.kernel.org with ESMTP id <S291222AbSBHAZQ>;
	Thu, 7 Feb 2002 19:25:16 -0500
Date: Thu, 07 Feb 2002 19:25:26 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: [PATCH] Fix floppy io ports reservation
To: linux-kernel@vger.kernel.org
Message-id: <1013127926.3988.712.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>ports 0x3f0 and 0x3f1 are used on certain PS/2 systems

Anton Altaparmakov wrote:
> Can you point me to the code for the PS/2 systems in
> question? I fail to see instances where anything less
> than 0x3f2 is used.

ports 0x3f0 and 0x3f1 were floppy-related on PS/2 systems,
but the current Linux floppy driver makes no use of 
these ports under any circumstances.




