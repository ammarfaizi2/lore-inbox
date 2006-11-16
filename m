Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031027AbWKPBnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031027AbWKPBnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031046AbWKPBnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:43:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:20197 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1031027AbWKPBnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:43:50 -0500
Date: Thu, 16 Nov 2006 02:43:30 +0100
From: Paul Seelig <pseelig@debian.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.18.2 kernel BUG at mm/vmscan.c:606!
Message-ID: <20061116014330.GA9041@rumbero.org>
Reply-To: Paul Seelig <pseelig@debian.org>
References: <45577194.4030406@debian.org> <20061112210017.5b42b880@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061112210017.5b42b880@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9cc55c12765367b21f2bbc8d7d4a18e0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 09:00:17PM +0100, Paolo Ornati wrote:
> 3) your kernel is also patched (Suspend2 isn't in vanilla kernels)
> 
> Suspend2 Core.
> Suspend2 Compression Driver loading.
> Suspend2 Encryption Driver loading.
> 
> So I suggest you to reproduce the problem with a vanilla/not tainted
> 2.6.18.2:
>
Thanks for pointing this out! I've been running a selfcompiled vanilla
kernel for the last three days without any of the reported problems
reappearing! :-)

As it looks like, the culprit seemed to be the suspend2 patch. I was not
aware of newer suspend2 patches for 2.6.18.2 and kept using the ones for
2.6.18 instead, which have applied perfectly.

Today i fetched the newest suspend2 patches and rebooted the machine with a
2.6.18.2 kernel containing them. Now let's see if the problem i reported
persists. If yes, i'll report them to Nigel Cunningham instead.

Thanks for the help!
