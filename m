Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSH1Qi1>; Wed, 28 Aug 2002 12:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSH1Qi1>; Wed, 28 Aug 2002 12:38:27 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:52493 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S315413AbSH1Qi0>;
	Wed, 28 Aug 2002 12:38:26 -0400
Subject: exporting symbols in kernel only when a module is compiled?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 12:39:50 -0400
Message-Id: <1030552792.581.38.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm sure this isn't limited to tcp_hashinfo, but does it make sense
to only export some symbols if "x" module is compiled into the kernel?  

For example with tcp_hashinfo, its only exported if ipv6 is compiled as
a module.  So if one statically compiles in ipv6 or doesnt compile it at
all, its not available to any other modules.  Is there a good reason for
it here?  Are there other similiar situations with other symbols? 
Should it be this way?  

It's possible to get around with recompiling modules and System.map
hackery, but should it be necessary?

thanks,

shaya



