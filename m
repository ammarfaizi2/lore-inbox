Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311862AbSCNXKC>; Thu, 14 Mar 2002 18:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311861AbSCNXJw>; Thu, 14 Mar 2002 18:09:52 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:29127 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S311859AbSCNXJs>; Thu, 14 Mar 2002 18:09:48 -0500
Date: Fri, 15 Mar 2002 00:09:41 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Jonathan Barker <jbarker@ebi.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <200203141351.NAA257264@alpha1.ebi.ac.uk>
Message-Id: <Pine.LNX.4.44.0203150006550.6903-100000@phobos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Jonathan Barker wrote:

> In brief: a kernel module which "exported" VFS requests to a (specified)
> user-space daemon would be useful. My particular application is a daemon
> which generates files on the fly - I would like to expose this as part of the
> filesystem. Ideally, the kernel module would deal with generation of fake
> inode numbers etc and the user-space daemon would simply be asked to create a
> pipe corresponding to a "filename" and (possibly) supply a directory tree.

I have experimented with using NFS for that -- start a local daemon that
exports a virtual filesystem and mount that. The great bonus is that it's
platform independent -- it works on Solaris, HP-UX and even Ultrix just as
well. Other projects have become more important, however, and I haven't
finished it. If you're interested, drop me a line.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

