Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271721AbRHUR1t>; Tue, 21 Aug 2001 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271731AbRHUR1j>; Tue, 21 Aug 2001 13:27:39 -0400
Received: from mout1.freenet.de ([194.97.50.132]:23505 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S271721AbRHUR11>;
	Tue, 21 Aug 2001 13:27:27 -0400
Message-ID: <3B82956A.1458E28F@athlon.maya.org>
Date: Tue, 21 Aug 2001 19:07:54 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [Fix] Re: [2.4.8-ac5 and earlier] fatal mount-problem
In-Reply-To: <Pine.GSO.4.21.0108200932070.2638-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Alan, please apply. sync_dev() in ->release() is 100% bogus - all flushing
> the stuff out is done by callers (blkdev_close() et.al.).

[...]

It's working fine in 2.4.8ac8 :-) .

Thank you very much!


Regards,
Andreas Hartmann
