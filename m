Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUIAQZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUIAQZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUIAQW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:22:28 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45707 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266463AbUIAQPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:15:48 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Claus =?ISO-8859-1?Q?F=E4rber?= <claus@faerber.muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <9FuGrTY3cDD@3247.org>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
	 <412E4999.1050504@sover.net>  <9FuGrTY3cDD@3247.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1094051610.2777.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 16:13:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 12:01, Claus Färber wrote:
> A simple convention that meta data files start with, say ".$", would be  
> enough.

POSIX/SuS don't permit this. The only "free" namespace is that starting
"//" (and not as some desktops seem to think foo://). Remember always
send GUI desktop users files called http://read.me  .. its fun 8)

The // doesn't really help because you don't want extensions at the path
top. 

Another interesting question btw with substreams of a file is what the
semantics of fchown, fstat, fchmod, fchdir etc are, or of mounting a
file over a substream.

Alan

