Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUDTS7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUDTS7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUDTS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:59:10 -0400
Received: from ee.oulu.fi ([130.231.61.23]:28579 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263663AbUDTS7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:59:06 -0400
Date: Tue, 20 Apr 2004 21:59:04 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: Support for building individual .ko's would be nice :-)
Message-ID: <20040420185904.GA27037@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was told you're the man to bug about this :-)

Having a slow box, a vendor kernel (+ kernel-source package with config
for it) and a need to modify one line of a module, recompile it,
replace existing module with it and continue business as usual
made me notice kbuild doesn't seem to have a facility for this.

What would be nice is (say)

cp configs/xxx-i686.config .config
emacs drivers/media/dvb/frontends/ves1820.c
make drivers/media/dvb/frontends/ves1820.ko
cp ves1820.ko /lib/modules/...
rmmod ves1820; modprobe ves1820 

Or am I missing something obvious that let me get just that one .ko
without recompiling just about everything? (.o is easy, but that's
not very useful :-) )

-- 
Pekka Pietikainen
