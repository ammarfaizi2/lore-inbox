Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJOLB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTJOLB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:01:26 -0400
Received: from oban.u-picardie.fr ([193.49.184.8]:42471 "EHLO
	mailx.u-picardie.fr") by vger.kernel.org with ESMTP id S262655AbTJOLBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:01:24 -0400
Date: Wed, 15 Oct 2003 13:01:22 +0200
From: Jean Charles Delepine <delepine@u-picardie.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
Message-ID: <20031015110122.GD994@u-picardie.fr>
References: <20031013185539.B1832@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031013185539.B1832@beton.cybernet.src>
X-Organization: Jack Daniel - Canal Habituel
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý <clock@twibright.com> écrivait (wrote) :

> 3) Bugreport: there should be written
> "Linux kernel depends on DocBook stylesheets. You may download DocBook
> stylesheets here-and-there." in README

In README you should have read :
                                      Please read the Changes file, as it
   contains information about the problems, which may result by upgrading
   your kernel.

 - The Documentation/DocBook/ subdirectory contains several guides for
   kernel developers and users.  These guides can be rendered in a
   number of formats:  PostScript (.ps), PDF, and HTML, among others.
   After installation, "make psdocs", "make pdfdocs", or "make htmldocs"
   will render the documentation in the requested format.

And in Documentation/Changes :

Linux documentation for functions is transitioning to inline
documentation via specially-formatted comments near their
definitions in the source.  These comments can be combined with the
SGML templates in the Documentation/DocBook directory to make DocBook
files, which can then be converted by DocBook stylesheets to PostScript,
HTML, PDF files, and several other formats.  In order to convert from
DocBook format to a format of your choice, you'll need to install Jade
as well as the desired DocBook stylesheets.

And :

Jade
----
o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>

DocBook Stylesheets
-------------------
o  <http://nwalsh.com/docbook/dsssl/>

Please RTFM before trying to compile your own kernel or use your 
favorite distribution's binary kernel.

Sincerly,
      Jean Charles
