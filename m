Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWHTPK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWHTPK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWHTPK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:10:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28939 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750708AbWHTPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:10:56 -0400
Date: Sun, 20 Aug 2006 17:10:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Maciej Rutecki <maciej.rutecki@gmail.com>,
       David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm2: AFS_FSCACHE=n compile error
Message-ID: <20060820151056.GL7813@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org> <44E86282.9020406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44E86282.9020406@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 03:24:18PM +0200, Maciej Rutecki wrote:
> Andrew Morton napisał(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> 
> Error while compile ("make all" command):
> 
> CC [M]  fs/afs/file.o
> fs/afs/file.c: In function 'afs_file_releasepage':
> fs/afs/file.c:332: error: 'struct afs_vnode' has no member named 'cache'
> make[2]: *** [fs/afs/file.o] Błąd 1
> make[1]: *** [fs/afs] Błąd 2
> make: *** [fs] Błąd 2
> 
> I download sources 2 times, and I have this error.

David, fs-cache-make-kafs-use-fs-cache-12.patch breaks 
CONFIG_AFS_FSCACHE=n builds.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

