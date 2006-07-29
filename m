Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWG2Nls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWG2Nls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWG2Nls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:41:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:44933 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932127AbWG2Nlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:41:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JdxefLPVOsy+iajHGtfbNv4c8u06aOSNLPaMwxFPRyxLfFZpDyiKSg+Lrk1lpelZKlu7QAd6OQrrAAwC63Cik2zU59sdRwhwzzKfMXiWWlKL30sVbrUPkznumvhCUWpYIF9YV4fCTiTVzBOddITnUofAeHTBlE7d83OviZ3ApYk=
Message-ID: <9a8748490607290641r51085a69vbea4192136f64e7c@mail.gmail.com>
Date: Sat, 29 Jul 2006 15:41:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc2-git7 build error with CONFIG_STACK_UNWIND enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For Your Information :

With 2.6.18-rc2-git7 I get the following build error if I have
CONFIG_STACK_UNWIND enabled :

  CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c: In function `show_trace_log_lvl':
arch/i386/kernel/traps.c:193: error: invalid type argument of `->'
arch/i386/kernel/traps.c:196: error: invalid type argument of `->'
arch/i386/kernel/traps.c:197: error: invalid type argument of `->'
make[1]: *** [arch/i386/kernel/traps.o] Error 1
make: *** [arch/i386/kernel] Error 2


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
