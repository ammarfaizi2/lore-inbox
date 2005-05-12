Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVELMGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVELMGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVELMGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:06:35 -0400
Received: from [62.203.34.148] ([62.203.34.148]:11317 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261514AbVELMGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:06:33 -0400
Date: Thu, 12 May 2005 14:03:58 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: make htmldocs doesn't work even with docbook stylesheets installed
Message-ID: <20050512120358.GA8126@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make htmldocs says thast docbook stylesheets are not installed while
they are:

kestrel linux-2.6.11.9 # make htmldocs
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  DOCPROC Documentation/DocBook/wanbook.sgml
*** You need to install DocBook stylesheets ***
make[1]: *** [Documentation/DocBook/wanbook.html] Error 1
make: *** [htmldocs] Error 2
kestrel linux-2.6.11.9 # emerge -s stylesheet
Searching...   
[ Results for search key : stylesheet ]
[ Applications found : 2 ]
 
*  app-text/docbook-dsssl-stylesheets
      Latest version available: 1.77-r2
      Latest version installed: 1.77-r2
      Size of downloaded files: 385 kB
      Homepage:    http://docbook.sourceforge.net
      Description: DSSSL Stylesheets for DocBook.
      License:     as-is

*  app-text/docbook-xsl-stylesheets
      Latest version available: 1.66.1
      Latest version installed: 1.66.1
      Size of downloaded files: 1,514 kB
      Homepage:    http://docbook.sourceforge.net/
      Description: XSL Stylesheets for Docbook
      License:     || ( as-is BSD )

Is this a bug in Linux make htmldocs?

CL<
