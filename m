Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271663AbSISQuw>; Thu, 19 Sep 2002 12:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271670AbSISQuw>; Thu, 19 Sep 2002 12:50:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15375 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271663AbSISQur>; Thu, 19 Sep 2002 12:50:47 -0400
Date: Thu, 19 Sep 2002 13:55:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/null broken in 2.5.36 ?
In-Reply-To: <200209191652.g8JGqgv10535@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44L.0209191355000.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Badari Pulavarty wrote:

> As you can from strace output, read on /dev/null returned "0" bytes.
> I wonder why ?

It's supposed to.  Try /dev/zero instead.

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

