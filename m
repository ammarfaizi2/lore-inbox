Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVD3GZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVD3GZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 02:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVD3GZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 02:25:03 -0400
Received: from mx1.mail.ru ([194.67.23.121]:63805 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262528AbVD3GY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 02:24:59 -0400
Date: Sat, 30 Apr 2005 10:28:17 +0000
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Karel Kulhavy <clock@twibright.com>
Cc: Randy Dunlap <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Which Docbook stylesheets?
Message-ID: <20050430102817.GA8356@mipter.zuzino.mipt.ru>
Mail-Followup-To: Karel Kulhavy <clock@twibright.com>,
	Randy Dunlap <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20050421151534.GA13245@beton.cybernet.src> <20050429222201.33fe9e6a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429222201.33fe9e6a.rddunlap@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:22:01PM -0700, Randy.Dunlap wrote:
> On Thu, 21 Apr 2005 15:15:34 +0000 Karel Kulhavy wrote:
> 
> | kestrel linux-2.6.11.7 # make htmldocs
> | *** You need to install DocBook stylesheets ***

This "help" text is very misleading.

> | *  app-text/docbook-dsssl-stylesheets

> | *  app-text/docbook-xsl-stylesheets

> | Which stylesheets?

You need db2html for HTML, and friends for other formats.

	# emerge jadetex

BUT#1: IIRC my Fedora life, db2html stopped working after sgmldocs => xmldocs
patch went into mainline. jadetex may or may not work.

BUT#2: I got HTML docs using -mm, because of jadetex => xmlto patch.

	# emerge xmlto

> I could be wrong, but I usually check Documentation/Changes for
> this info, which says:
> 
> DocBook Stylesheets
> -------------------
> o  <http://nwalsh.com/docbook/dsssl/>

