Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTKJNbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTKJNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:31:08 -0500
Received: from gate.corvil.net ([213.94.219.177]:14345 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262580AbTKJNbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:31:05 -0500
Message-ID: <3FAF9335.9010801@draigBrady.com>
Date: Mon, 10 Nov 2003 13:31:33 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] cfq + io priorities
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au> <1068469674.734.80.camel@cube>
In-Reply-To: <1068469674.734.80.camel@cube>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Besides, the kernel load average was changed to
> include processes waiting for IO. It just plain
> makes sense to mix CPU usage with IO usage by
> default. Wanting different niceness for CPU
> and IO is a really unusual thing.

I strongly agree. Of course it would be
nice/necessary to have seperate nice values,
but setting the global one should set the
underlying ones (cpu, disk, ...) also.

Pádraig.

