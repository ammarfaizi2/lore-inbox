Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSH1C64>; Tue, 27 Aug 2002 22:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318635AbSH1C64>; Tue, 27 Aug 2002 22:58:56 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:7949 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S318591AbSH1C64>;
	Tue, 27 Aug 2002 22:58:56 -0400
Subject: tcp_hashinfo exported or not?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Aug 2002 23:00:21 -0400
Message-Id: <1030503622.487.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some slight issues with using tcp_hashinfo in 2.4.19.  It
appears to be exported (net/netsyms.c), appears in the System.map
generated, but when I try to load a module that makes use of it, insmod
claims it isn't there (and isn't listed in /proc/ksyms either,
explaining why insmod complains).

Is there any voodoo that I have to do to make use of this symbol in a
module?

thanks,

shaya



