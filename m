Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317685AbSGJX7S>; Wed, 10 Jul 2002 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317687AbSGJX7R>; Wed, 10 Jul 2002 19:59:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51469 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317685AbSGJX7Q>; Wed, 10 Jul 2002 19:59:16 -0400
Date: Wed, 10 Jul 2002 21:01:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Karthikeyan Nathillvar <ntkarthik@ittc.ku.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process Memory Usage
In-Reply-To: <Pine.LNX.4.33.0207101811550.4626-100000@plato.ittc.ku.edu>
Message-ID: <Pine.LNX.4.44L.0207102101100.14432-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Karthikeyan Nathillvar wrote:

>  2) I tried to read from /proc/<pid>/statm file. But, the process memory
> usage seems to be always in an increasing trend, even though lot of
> freeing is going on inside. All the values, size, resident, are always
> increasing.

Remember that when you call free() glibc may decide to just
keep the memory for itself and not give it back to the OS,
so the memory is still in use by the process...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

