Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312238AbSCRIK4>; Mon, 18 Mar 2002 03:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312237AbSCRIKr>; Mon, 18 Mar 2002 03:10:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312232AbSCRIKi>;
	Mon, 18 Mar 2002 03:10:38 -0500
Message-ID: <3C95A0DB.40008@mandrakesoft.com>
Date: Mon, 18 Mar 2002 03:10:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <3C945D7D.8040703@mandrakesoft.com> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>Other applications can use this sort of stuff.  DBM could, for
>instance.  So might GIMP.  Etc.  Dynamic hints have real world
>applications.
>

to be fair, fcntl(2) could be used in conjunction with open(2), to do 
dynamic hints.

I prefer to separate the hints from other O_xxx flags, though, so 
posix_fadvise seems to be applicable...

    Jeff




