Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbRLZFmc>; Wed, 26 Dec 2001 00:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbRLZFmW>; Wed, 26 Dec 2001 00:42:22 -0500
Received: from bof.de ([195.4.223.10]:55046 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S286178AbRLZFmN>;
	Wed, 26 Dec 2001 00:42:13 -0500
Date: Wed, 26 Dec 2001 06:48:22 +0100
From: Patrick Schaaf <bof@bof.de>
To: James Stevenson <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: file names ?
Message-ID: <20011226064822.Q14419@oknodo.bof.de>
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org>; from mistral@stev.org on Tue, Dec 25, 2001 at 08:25:48PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i could not help but notice in the kernel source
> in both the ipv4/netfilter and ipv6/netfilter
> dirs there are files the same name which can cause problems
> under certin conditions like non-case sensitive file systems.
>[...] 
> this does not cause a problem for me but i do
> know people who it does cause a problem for
>[...] 
> anyone got any suggestions ?

Yes: don't worry. That's Unix.

> a small example is a smallish ext2 / filesystem
> and the rest being a fat filesystem to that
> it can be accessed from both windows and linux.
> and there is not enough space on the ext2 to compile a kernel anymore.

There's a very simple means to "solve" that scenario, if you are the
one in a million people who happens to have such a setup, _and_ want
to recompile your kernel from scratch: create a loop mount file on the
FAT partition, create an ext2fs there, mount that, and compile on it.

Problem solved.

best regards
  Patrick
