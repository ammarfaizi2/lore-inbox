Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbRGPAzX>; Sun, 15 Jul 2001 20:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbRGPAzN>; Sun, 15 Jul 2001 20:55:13 -0400
Received: from stine.vestdata.no ([195.204.68.10]:20745 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S267171AbRGPAzA>; Sun, 15 Jul 2001 20:55:00 -0400
Date: Mon, 16 Jul 2001 02:54:52 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: volodya@mindspring.com
Cc: Alexander Viro <viro@math.psu.edu>,
        Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Message-ID: <20010716025452.A29050@vestdata.no>
In-Reply-To: <Pine.GSO.4.21.0107151204060.24930-100000@weyl.math.psu.edu> <Pine.LNX.4.20.0107152032440.1154-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.LNX.4.20.0107152032440.1154-100000@node2.localnet.net>; from volodya@mindspring.com on Sun, Jul 15, 2001 at 08:50:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 08:50:03PM -0400, volodya@mindspring.com wrote:
> Umm that is very interesting - I was rather sure there were some problems
> a while ago (2.2.x ?). Is there anything special necessary to use large
> files ? Because I tried to create a 3+gig file and now I cannot ls or rm
> it. (More details: the file was created using dd from block device (tried
> to backup a smaller ext2 partition), ls and rm say  "Value too large for
> defined data type" and I upgraded everything mentioned in Documentation/Changes).

Your utilities must be compiled with a recent glibc and with LFS (large
file support). Any recent distribution should support this.


-- 
Ragnar Kjorstad
Big Storage
