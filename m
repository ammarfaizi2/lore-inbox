Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTA0I5g>; Mon, 27 Jan 2003 03:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTA0I5g>; Mon, 27 Jan 2003 03:57:36 -0500
Received: from [213.86.99.237] ([213.86.99.237]:42719 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261599AbTA0I5f>; Mon, 27 Jan 2003 03:57:35 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030127061720.GB13835@vana.vc.cvut.cz> 
References: <20030127061720.GB13835@vana.vc.cvut.cz>  <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> 
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Christian Zander <zander@minion.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Jan 2003 09:02:11 +0000
Message-ID: <12104.1043658131@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vandrove@vc.cvut.cz said:
> From my exprience at VMware newsgroups distros have bad troubles even
> with delivery of basic configured kernel headers matching to kernel
> binaries they provide (it is not unusual that for example they go from
> 1GB to 4GB kernel without make mrproper so kmap/kunmap do not have
> proper versions attached :-( or they even sell headers and binaries
> with different configs).

But you _need_ the config. Even with your own makefiles, how are you going
to get it right for all new kernels that $CRAPDISTRO ships in a broken form, 
if you don't have the configs?

If distros ship broken crap which doesn't let you build modules, there's 
really not a lot you can do except note their quality control for the 
record and report it in their bug tracking system.

You are _always_ going to have problems with people shipping shite, or
possibly even actively going our of their way to prevent out-of-tree modules
building. It's fairly much an orthogonal problem though, isn't it?

--
dwmw2


