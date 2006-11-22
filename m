Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755490AbWKVQpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbWKVQpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbWKVQpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:45:12 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:34870 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1755490AbWKVQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:45:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lz1w0QxTwPHuNovfyiVWvN6nB6krCi4bhnN2cpIhaTS3Cyq5OIAJjUbxXI1bVt2DT8zp3tnetthOIkc1FMfS7L2xkdYSA22bBt0yq2TRRKa2A8Sn2tMUR71T/Xjvqkh0It4q9j4U267VDEbajMrbFzO5R5pQr0ltKVDWo/EkYBw=
Message-ID: <9a8748490611220845g33afefceke191786fbb62adb@mail.gmail.com>
Date: Wed, 22 Nov 2006 17:45:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: irda: allyesconfig build failure (2.6.19-rc6-git_HEAD)
Cc: "Dag Brattli" <dagb@cs.uit.no>, "Jean Tourrilhes" <jt@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this while building an allyesconfig kernel from current git HEAD :


  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o: In function `irlmp_slsap_inuse':
net/irda/irlmp.c:1681: undefined reference to `spin_lock_irqsave_nested'
make: *** [.tmp_vmlinux1] Error 1

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
