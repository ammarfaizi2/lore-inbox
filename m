Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJPRlb>; Tue, 16 Oct 2001 13:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJPRlW>; Tue, 16 Oct 2001 13:41:22 -0400
Received: from t2.redhat.com ([199.183.24.243]:19708 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S276451AbRJPRlO>; Tue, 16 Oct 2001 13:41:14 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com> 
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Cristiano Paris <c.paris@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 18:36:16 +0100
Message-ID: <4170.1003253776@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  The -ac tree is moving to a single copy of zlib, in fs/inflate_fs.
> It is currently used by cramfs and zisofs.  jffs2 in the -ac tree
> still uses its own copy of zlib and should be converted. 

AFAIK the new zlib doesn't (yet) do compression, so JFFS2 can't use it.

--
dwmw2


