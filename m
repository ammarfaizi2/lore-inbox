Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbTCZXlf>; Wed, 26 Mar 2003 18:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCZXj4>; Wed, 26 Mar 2003 18:39:56 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:62403 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262656AbTCZXjp>; Wed, 26 Mar 2003 18:39:45 -0500
Message-Id: <200303262350.h2QNoqjd015366@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Date: Wed, 26 Mar 2003 23:44:51 +0100
References: <20030326163014$65d6@gated-at.bofh.it> <20030326201008$0568@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> Now actually take a look at this diff :)  The biggest part is that the
> s390 compat files exist only on s390x and the math-emu dir only exists
> on s390, that's just a matter of conditionally compiling the files.

I agree that it would be nice to do this merge and that it can be done
without introducing much ugliness. However, removing a whole arch
tree would be a major change considering that we are in the middle
of what is supposed to be a feature freeze.

I'd rather do it early in the 2.7 series unless more people agree it
should be done now.

        Arnd <><
