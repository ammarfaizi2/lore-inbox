Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbSISQ4D>; Thu, 19 Sep 2002 12:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbSISQ4D>; Thu, 19 Sep 2002 12:56:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:46038 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S271719AbSISQ4C>;
	Thu, 19 Sep 2002 12:56:02 -0400
Subject: Re: /dev/null broken in 2.5.36 ?
From: Sebastian Heidl <heidl@zib.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209191652.g8JGqgv10535@eng2.beaverton.ibm.com>
References: <200209191652.g8JGqgv10535@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Sep 2002 18:59:42 +0200
Message-Id: <1032454783.1192.13.camel@csr-pc10>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Don, 2002-09-19 at 18:52, Badari Pulavarty wrote:
> /dev/null seems to be broken in 2.5.36 (and also 2.5.35)
> 
> [root@elm3b81 root]# uname -a
> Linux elm3b81 2.5.36 #0 SMP Thu Sep 19 09:11:08 PDT 2002 i686 unknown
> 
> [root@elm3b81 root]# dd if=/dev/null of=/tmp/file bs=512 count=100
> 0+0 records in
> 0+0 records out
> 
> [root@elm3b81 root]# ls -l /tmp/file
> -rw-r--r--    1 root     root            0 Sep 19 09:28 /tmp/file

try to read from /dev/zero

HTH,
_sh_

