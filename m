Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUAMJxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUAMJxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:53:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:18887 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263800AbUAMJxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:53:18 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16387.49164.269996.500699@laputa.namesys.com>
Date: Tue, 13 Jan 2004 12:53:16 +0300
To: Dan Egli <dan@eglifamily.dnsalias.net>
Cc: linux-kernel@vger.kernel.org,
       =?koi8-r?B?78zFxw==?= =?koi8-r?B?5NLPy8nO?= 
	<Green@LinuxHacker.RU>
Subject: Re: 2.6.x breaks some Berkeley/Sleepycat DB functionality
In-Reply-To: <4002D65C.1010505@eglifamily.dnsalias.net>
References: <4002D65C.1010505@eglifamily.dnsalias.net>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Egli writes:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > I have encountered a strange issue in 2.6.0 and 2.6.1
 > 
 > I run a PGP Public key server on this machine and under 2.4.x it's
 > "smooth as silk". But if I boot under 2.6.x, it's gaurenteed failure. If
 > I try to build a database using the build command (this is an sks
 > server, so it's sks build or sks fastbuild) I IMMEDIATELY get  Bdb
 > error. But the exact same command with the exact same libraries and
 > input files under 2.4.20 works without a hitch.
 > 
 > Anyone got any ideas? Anything else I can provide to assist in debugging?

On top of what file system berkdb is created? I have a reminiscence that
Sleepy Cat used to have a problem with reiserfs, due to large
stat->st_blksize value. Oleg do you remember this?

 > 
 > - --- Dan

Nikita.

