Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSBFAUB>; Tue, 5 Feb 2002 19:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSBFATv>; Tue, 5 Feb 2002 19:19:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289877AbSBFATm>; Tue, 5 Feb 2002 19:19:42 -0500
Message-ID: <3C607683.9050501@zytor.com>
Date: Tue, 05 Feb 2002 16:19:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <UTC200202052356.g15Nu1w00794.aeb@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> 
> Peter, in my eyes this is an unreasonable answer.
> 
> For debugging and other purposes it is good to have some
> information. One may wish to know about a certain kernel image
> what Linux kernel version that was, with what patches, compiled
> with what options, by which compiler. Or one may want to know
> such things about the currently running kernel. Even user-space
> programs (like mount) may want to know (what NFS version? do we
> have CONFIG_JOLIET?).
> 


The proposed /proc/config stuff don't solve those problems, however.  For
one thing, either one of those might be in modules, and the modules might
not match what the kernel was compiled at the same time as.

	-hpa

