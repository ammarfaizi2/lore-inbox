Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTIGFnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIGFnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:43:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32260 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263151AbTIGFna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:43:30 -0400
Date: Sun, 7 Sep 2003 07:43:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Furesz Peter <webmaster@srv.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: KERNEL_BUG - missing file
Message-ID: <20030907054328.GC963@mars.ravnborg.org>
Mail-Followup-To: Furesz Peter <webmaster@srv.hu>,
	linux-kernel@vger.kernel.org
References: <000e01c374cf$01469100$0200a8c0@asuspeter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01c374cf$01469100$0200a8c0@asuspeter>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 01:31:32AM +0200, Furesz Peter wrote:
> 
> I attached a kernel config file, you have to load after "make menuconfig".
> Always get an error
> after "make bzImage".
> 
> ld: cannot open drivers/acpi/acpi.o: No such file or directory
> make: *** [vmlinux] Error 1

Look like you encountered a bug in acpi somewhere. Check what file
could not compile and pot relevant output about that file.
acpi.o is made from several .o files and one of them could not be made.

	Sam
