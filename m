Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVHLKk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVHLKk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHLKk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:40:26 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:9128 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932150AbVHLKkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:40:25 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Carr <jcarr@linuxmachines.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FC2DE4.4010608@linuxmachines.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <1123780681.17269.71.camel@localhost.localdomain>
	 <42FC2DE4.4010608@linuxmachines.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 06:40:17 -0400
Message-Id: <1123843217.17269.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 22:04 -0700, Jeff Carr wrote:

> root@jcarr:~# dpkg -s libc6-i686
> ...

OK, this explains it :-)

# dpkg -s libc-i686
Package `libc-i686' is not installed and no info is available.

# dpkg -s libc6
Package: libc6
Status: install ok installed
Priority: required
Section: base
Installed-Size: 16336
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Architecture: i386
Source: glibc
Version: 2.3.5-3
Replaces: ldso (<= 1.9.11-9), timezone, timezones, gconv-modules,
libtricks, libc6-bin, netkit-rpc, netbase (<< 4.0)
Provides: glibc-2.3.5-3
Suggests: locales, glibc-doc
Conflicts: strace (<< 4.0-0), libnss-db (<= 2.2-6.1.1), timezone,
timezones, gconv-modules, libtricks, libc6-doc, libc5 (<< 5.4.33-7),
libpthread0 (<< 0.7-10), libc6-bin, libwcsmbs, apt (<< 0.3.0),
libglib1.2 (<< 1.2.1-2), netkit-rpc, wine (<< 0.0.20031118-1),
cyrus-imapd (<< 1.5.19-15), initrd-tools (<< 0.1.79)
Description: GNU C Library: Shared libraries and Timezone data
 Contains the standard libraries that are used by nearly all programs on
 the system. This package includes shared versions of the standard C
library
 and the standard math library, as well as many others.
 Timezone data is also included.

-- Steve


