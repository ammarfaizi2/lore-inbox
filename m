Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWJWGeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWJWGeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWJWGeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:34:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:14221 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751597AbWJWGeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:34:36 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <453C6260.7060609@s5r6.in-berlin.de>
Date: Mon, 23 Oct 2006 08:34:08 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230242.58647.ak@suse.de> <20061023010812.GE25210@parisc-linux.org> <200610230331.16573.ak@suse.de> <20061023013604.GF25210@parisc-linux.org> <453C1FB5.9070007@yahoo.com.au>
In-Reply-To: <453C1FB5.9070007@yahoo.com.au>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
...
> If you have an
> 
> #ifndef _LINUX_INTERRUPT_H
> #error ...
> 
> That almost explicitly tells you which is the correct file to include to
> get all definitions from this file. Wouldn't that help?

This can even be evaluated by a script that searches for required header
files, except if more than one of such clauses appear in a file.
-- 
Stefan Richter
-=====-=-==- =-=- =-===
http://arcgraph.de/sr/
