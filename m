Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSL2S16>; Sun, 29 Dec 2002 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSL2S15>; Sun, 29 Dec 2002 13:27:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261321AbSL2S1z>;
	Sun, 29 Dec 2002 13:27:55 -0500
Date: Sun, 29 Dec 2002 10:33:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6 
In-Reply-To: <20021229062833.1598F2C085@lists.samba.org>
Message-ID: <Pine.LNX.4.33L2.0212291029540.10723-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Rusty Russell wrote:

| In message <957BD1C2BF3CD411B6C500A0C944CA2601AA1378@pdsmsx32.pd.intel.com> you
|  write:
| > > Now, why do you want /proc/ksyms exactly?  I'm not hugely opposed to
| > > it, but it's rarely what people actually want, since it contains only
| > > exported symbols.
| > The two things make me want ksyms... ;-)
|
| > First, if I'm a stranger to a system, how can I know if a feature
| > (preemptive, for example) is on/off on that?
|
| Um, you read the .config, which hopefully is stored somewhere.
| (Although you could resurrect the /proc/config patch which goes around
| every so often).  There are many things you can't tell by reading
| /proc/ksyms.

Right, the .config file is the answer.  And there are at least 2
patch solutions for it, the /proc/config that Rusty mentioned, or
the in-kernel config that Khalid Aziz and others from HP did along
with me, and it's in 2.4.recent-ac or 2.5.recent-dcl or 2.5.recent-cgl.

-- 
~Randy


