Return-Path: <linux-kernel-owner+w=401wt.eu-S964996AbWL1J1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWL1J1U (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWL1J1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:27:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:22084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996AbWL1J1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:27:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WthTBIJ85tReLy5/SL2HL/NIMNhP+TjOFWs+6ZkuKUcphLJFJ6tO9bI72ndsTPfcSI5vw5vFPCK503STxlV/R6A54OnEKQz756lg0JGIaG5BLX07MH2JcYLmvABd5/68zjTChW74Cam/LTasiMTWvprcZiGg7djd8pchDXe6VGo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Date: Thu, 28 Dec 2006 10:27:09 +0100
User-Agent: KMail/1.9.5
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281027.09783.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get this message in my webservers (with NFS mounted homedirs) logs once 
in a while : 

  kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

It doesn't seem to have any bad effect on anything, but it would be nice 
to know if there is any cause for concern.

The NFS server is running 2.6.18.1 and the webservers are running 2.6.17.8


-- 
Jesper Juhl <jesper.juhl@gmail.com>

