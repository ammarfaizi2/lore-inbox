Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSHHMVx>; Thu, 8 Aug 2002 08:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSHHMVx>; Thu, 8 Aug 2002 08:21:53 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:18872 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317547AbSHHMVu>; Thu, 8 Aug 2002 08:21:50 -0400
Date: Thu, 8 Aug 2002 13:25:05 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alexandre Julliard <julliard@winehq.com>
Subject: Re: [patch] tls-2.5.30-A1
Message-ID: <20020808132505.A26548@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>; from mingo@elte.hu on Wed, Aug 07, 2002 at 08:10:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the attached patch (against BK-curr + Luca Barbieri's two TLS patches)  
> does two things:
> 
>  - it implements a second TLS entry for Wine's purposes.

Oh good; I was going to ask for this.  Wine isn't the only program that
wants to use its own thread-local storage mechanism and link with Glibc
at the same time.

The LDT works, but with limitations and overhead.

thanks,
-- Jamie
