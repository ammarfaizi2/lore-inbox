Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSJIJ1Q>; Wed, 9 Oct 2002 05:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbSJIJ1Q>; Wed, 9 Oct 2002 05:27:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261374AbSJIJ0t>;
	Wed, 9 Oct 2002 05:26:49 -0400
Date: Wed, 9 Oct 2002 00:54:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Dow, Benjamin" <bdow@itouchcom.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Rik van Riel'" <riel@conectiva.com.br>
Subject: Re: kernel memory leak?
Message-ID: <20021008225400.GA889@elf.ucw.cz>
References: <19EE6EC66973A5408FBE4CB7772F6F0A046A39@ltnmail.xyplex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A046A39@ltnmail.xyplex.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I sent this out yesterday, and never got a reply.  Normally, I'd be far more
> patient, but I'm afraid that by now people have forgotten about it, and I'm
> under a LOT of pressure by management to get this fixed soon.
> 
> To recap my previous e-mail, every time I access a file, 4k of memory gets
> allocated, and never gets freed, to the point of eventually triggering the
> OOM killer.  I don't know nearly enough about the VM to debug this myself,
> so even a pointer to where to start looking would be helpful.

Write C code to reproduce this on normal machine, and post it to
bugtraq (its DoS, after all). Pretty aggresive but sure to get fixed
*fast*.

The same without going bugtraq should suffice, through.
									Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
