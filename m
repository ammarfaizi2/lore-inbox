Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291158AbSBGSMI>; Thu, 7 Feb 2002 13:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSBGSLu>; Thu, 7 Feb 2002 13:11:50 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:63646 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S291158AbSBGSLd>;
	Thu, 7 Feb 2002 13:11:33 -0500
Date: Thu, 07 Feb 2002 13:11:43 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: [PATCH] read() from driverfs files can read more bytes
To: linux-kernel@vger.kernel.org
Message-id: <1013105503.3986.687.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you also check for size >= PAGE_SIZE on enter
> to entry->show() procedure?

FYI I recently wrote a patch for procfs which addresses a
similar problem there.  See the link at:
   http://panopticon.csustan.edu/thood/pnpbios.html

--
Thomas Hood


