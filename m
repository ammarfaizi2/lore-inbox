Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSIZQB7>; Thu, 26 Sep 2002 12:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSIZQB7>; Thu, 26 Sep 2002 12:01:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:60665
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261353AbSIZQA5>; Thu, 26 Sep 2002 12:00:57 -0400
Subject: Re: 2.5.38: modular IDE broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m17tqRL-0005khC@gherkin.frus.com>
References: <m17tqRL-0005khC@gherkin.frus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 17:10:42 +0100
Message-Id: <1033056642.1269.64.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Specific example: proc_ide_read_geometry has the requisite EXPORT_SYMBOL()
> wrapper in ide-proc.c, yet, I still end up with proc_ide_read_geometry_R*
> unresolved at depmod time.  In case anyone is wondering, I *did* do a
> "make clean", manually cleaned out linux/include/modules to make *sure*

Let me give a simple clear explanation here. I don't give a flying ***k
about modular IDE until the IDE works. Cleaning up the modular IDE after
it all works is relatively easy and gets easier the more IDE is cleaned
up. Until then its not even on the radar unless someone else wants to do
all the work for 2.4/2.5 and verify/test them

