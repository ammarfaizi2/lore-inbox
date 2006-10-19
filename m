Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWJSFqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWJSFqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWJSFqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:46:10 -0400
Received: from mx10.go2.pl ([193.17.41.74]:31104 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030303AbWJSFqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:46:07 -0400
Date: Thu, 19 Oct 2006 07:51:12 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DocBook with .txt or .html versions?
Message-ID: <20061019055112.GA1872@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20061018114240.GA3202@ff.dom.local> <20061018084105.56d61e04.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018084105.56d61e04.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 08:41:05AM -0700, Randy Dunlap wrote:
> On Wed, 18 Oct 2006 13:42:40 +0200 Jarek Poplawski wrote:
> 
> > Is it really so superfluous to have a possibility of 
> > reading all docs from Documentation on a lean box
> > (e.g. server) without all those xml, flex etc.
> > printers' toys installed?
> 
> make help ==>
> 
> Documentation targets:
>   Linux kernel internal documentation in different formats:
>   xmldocs (XML DocBook), psdocs (Postscript), pdfdocs (PDF)
>   htmldocs (HTML), mandocs (man pages, use installmandocs to install)
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> and 'man 9 yield'
> works for me.
> 
> or are you saying that you want large *.txt book-like generated files
> instead of larger *.html etc?

I'm saying that I coudn't do it even on knoppix dvd version
(a year ago) and there are gazillions of desktop software
which I don't use.

I only need to read this in any readable form like
the rest of Documentation.

Regards,
Jarek P.

-------------
Slackware_lean_box$ make mandocs

*** You need to install xmlto ***
make[1]: *** [Documentation/DocBook/wanbook.9] Error 1
make: *** [mandocs] Error 2

-------------
http://rpmfind.net//linux/RPM/fedora/4/i386/xmlto-0.0.18-6.i386.html
Provides

    * xmlto 

Requires

    * /bin/bash
    * docbook-dtds
    * docbook-xsl
    * libc.so.6
    * libxslt >= 0.9.0
    * passivetex 

http://rpmfind.net//linux/RPM/fedora/4/i386/passivetex-1.25-5.noarch.html
Provides

    * passivetex 

Requires

    * /bin/sh
    * /bin/sh
    * /bin/sh
    * tetex >= 3.0
    * xmltex >= 20000118-4 

http://rpmfind.net//linux/RPM/fedora/4/i386/libxslt-1.1.14-2.i386.html
Provides

    * libxslt
    * libexslt.so.0
    * libxslt.so.1 

Requires

    * /bin/sh
    * /bin/sh
    * libc.so.6
    * libexslt.so.0
    * libgcrypt.so.11
    * libgpg-error.so.0
    * libm.so.6
    * libpthread.so.0
    * libxml2 >= 2.3.8
    * libxml2.so.2
    * libxslt.so.1
    * libz.so.1 

http://rpmfind.net//linux/RPM/fedora/4/i386/docbook-dtds-1.0-26.noarch.html
Provides

    * docbook-dtds
    * docbook-dtd-sgml
    * docbook-dtd-xml
    * docbook-dtd30-sgml
    * docbook-dtd31-sgml
    * docbook-dtd40-sgml
    * docbook-dtd41-sgml
    * docbook-dtd412-xml
    * docbook-dtd42-sgml
    * docbook-dtd42-xml
    * docbook-dtd43-sgml
    * docbook-dtd43-xml
    * docbook-dtd44-sgml
    * docbook-dtd44-xml 

Requires

    * /bin/sh
    * /bin/sh
    * fileutils
    * grep
    * libxml2 >= 2.3.8
    * openjade = 1.3.2
    * perl >= 0:5.002
    * sgml-common >= 0.6.3-4
    * textutils
    * xml-common
    * xml-common 

etc, etc, etc...
