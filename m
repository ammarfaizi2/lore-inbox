Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTEFWRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbTEFWRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:17:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63874
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261974AbTEFWRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:17:18 -0400
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506221819.GC6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk>
	 <20030506204305.GA5546@elf.ucw.cz>
	 <20030506221819.GC6284@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052256672.1983.174.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 22:31:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 23:18, Jamie Lokier wrote:
> If I load a Java class into a Java VM, that class is executing in the
> VM's "userspace", even though both the class and VM execute together
> in the underlying kernel's userspace.  If I load an Emacs Lisp library
> into Emacs, that's ok too in the same way.

Thats not actually clear either. The kernel contains the clear syscall
message for good reasons. The GPL itself talks about stuff that comes
normally with the OS very carefully for similar reasons.

You see there isn't any difference between an interpreter hitting
	Java bytecode 145
and a function call of 
	perform_java_bytecode(145);

Indeed the JVM may turn one into the other.


If you think that is bad remember that the DMCA and other rulings have
held shrink wrap licenses can sometimes overrule US style "fair use", so
your JVM in JITting code may be making you liable for a license
violation for some applications.

Corner cases are fun in more than just the computing profession 8)


