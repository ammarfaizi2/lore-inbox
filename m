Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUJNWOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUJNWOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJNWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:13:49 -0400
Received: from smtp.terra.es ([213.4.129.129]:39633 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S267638AbUJNV4w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:56:52 -0400
Date: Thu, 14 Oct 2004 23:57:02 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announcing Binary Compatibility/Testing
Message-Id: <20041014235702.43586f70.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.58.0410141129200.3897@ppc970.osdl.org>
References: <1097705813.6077.52.camel@wookie-zd7>
	<416DAEB7.4050108@pobox.com>
	<1097709855.5411.20.camel@localhost>
	<Pine.LNX.4.58.0410141129200.3897@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 14 Oct 2004 11:32:14 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> escribió:

> No we don't.
> 
> Yes, we "have the technology". But it's not actually used for libc (which
> is most of the problematic stuff), so we do not actually have library
> versioning.

is that a solvable problem?
quoting some dragonfly thread (whose aim is to implement something which 
would solve that)

    [...] via VFS 'environments', causes any particular package to see only
    the dependancies that it depends on, and the proper version of said
    dependancies as well.  Multiple versions of third party apps that normally
    conflict with each other could be installed simultaniously.  The
    packaging-system-controlled VFS environment would also hide everything a
    package does not depend on, like other libraries in the system, in order
    to guarentee that the dependancies listed in the packaging system are in
    fact what the application depends on.  There's no point in having a
    packaging system that can't detect broken and incorrect dependancies or
    we wind up with the same mess that we have with ports.

Diego Calleja (who wonders if this is feasible/worth of it)
