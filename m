Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290641AbSBSWec>; Tue, 19 Feb 2002 17:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSBSWeX>; Tue, 19 Feb 2002 17:34:23 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33811 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290641AbSBSWeU>;
	Tue, 19 Feb 2002 17:34:20 -0500
Date: Tue, 19 Feb 2002 19:34:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mihail Ionescu <mihaii@caip.rutgers.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap for more than 2GB
In-Reply-To: <Pine.GSO.4.33.0202191623310.6384-100000@caip.rutgers.edu>
Message-ID: <Pine.LNX.4.33L.0202191933260.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Mihail Ionescu wrote:

> I am currently working on the porting of some programs from Solaris to
> Linux. The main problem I have is that the original programs heavily use
> mmap in order to access very big files (more than 4GB) (since it is a
> 64 bits operating system), but on Linux mmap will fail. Is there any clean
> way to solve this problem?

You could use a machine with 64 bits of address space.

Linux on Intel hardware cannot mmap() more than about
2 GB per process since the hardware doesn't support
more.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

