Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271418AbRHUDDS>; Mon, 20 Aug 2001 23:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271417AbRHUDDI>; Mon, 20 Aug 2001 23:03:08 -0400
Received: from rj.SGI.COM ([204.94.215.100]:14785 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271432AbRHUDCv>;
	Mon, 20 Aug 2001 23:02:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andr Dahlqvist <andre.dahlqvist@telia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'make dep' produces lots of errors with this .config 
In-Reply-To: Your message of "Fri, 17 Aug 2001 23:46:26 +0200."
             <20010817234626.A29467@telia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 13:02:57 +1000
Message-ID: <18695.998362977@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001 23:46:26 +0200, 
Andr Dahlqvist <andre.dahlqvist@telia.com> wrote:
>I have come across what might be a problem and what might be completely
>harmless. I have noticed that when I configure my kernel in a certain
>way (the config file is attached) 'make dep' produces these errors while
>it is being run (these are just the errors, normal output is omitted):

Ignore all error and warning messages from make dep.  It always
generates spurious messages, because it tries to read all architecture
"independent" source files.  The design is broken, make dep will be
removed in kernel 2.5.

