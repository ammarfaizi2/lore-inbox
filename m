Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281369AbRKZBsd>; Sun, 25 Nov 2001 20:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281371AbRKZBsW>; Sun, 25 Nov 2001 20:48:22 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:44297 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281369AbRKZBsM>;
	Sun, 25 Nov 2001 20:48:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Ford <david@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.16-pre1 not compiling without SMP 
In-Reply-To: Your message of "Sun, 25 Nov 2001 15:37:21 CDT."
             <3C015681.8080006@blue-labs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 12:47:59 +1100
Message-ID: <1341.1006739279@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 15:37:21 -0500, 
David Ford <david@blue-labs.org> wrote:
>After you have enabled SMP in a past configuration, to compile without 
>SMP, you must do a 'make distclean'.  It's a bug in the current config 
>stuff that hasn't ever been addressed.

Mainly because it is unfixable with the current kernel build system, it
needs a complete redesign.  Why do you think I wrote kbuild 2.5?

