Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWGIMOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWGIMOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWGIMOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:14:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37401 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030199AbWGIMOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:14:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:content-transfer-encoding:from;
        b=I3uv8LOHp+Z7wG+ekJowTkHVQm1t5TCPza4D+X3iOGkHVxlM5wZwydFOBAYGIIAcmz1BTj7iyDtlM2TG0etxRohfUJbfa5SZML5HiED07XwCriofO2SbteQ4z/ZbFc6OiZSxXk9LcH1ugYzUMMg9COs/YEmwX+assF7b5pXh5io=
Date: Sun, 9 Jul 2006 13:49:25 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Message-ID: <20060709114925.GA9009@gmail.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
X-Operating-System: Linux 2.6.17-mm5
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can't compil it :

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o: In function `vsyscall_set_cpu':
(.init.text+0x1e87): undefined reference to `smp_call_function_single'
make: *** [.tmp_vmlinux1] Error 1

Please CC to me if some more infos are needed as I am not on the list.
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
