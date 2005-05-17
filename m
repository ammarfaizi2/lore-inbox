Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVEQTxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVEQTxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEQTxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:53:41 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:50520 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261788AbVEQTxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:53:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AQy8hv+4S5iyDdM1Mb+joViujhFCU3oGQTQ/AYjmJqjAVphAB4gLtGUoYxXJLUu6KTJYCQcxnxu2GSifDarK3IUXgNuJAHknJ3QiutKsVomv1Xlb53U8Xb/Qwz9HPNW/9ejP2I+0RTs6H417qMTGh4p+7Mf2zz+aOfe5Dcx7S1Q=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Karel Kulhavy <clock@twibright.com>
Subject: Re: make htmldocs doesn't work even with docbook stylesheets installed
Date: Tue, 17 May 2005 23:56:45 +0400
User-Agent: KMail/1.7.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050512120358.GA8126@kestrel> <20050512212918.GA3603@stusta.de> <20050517192209.GB19373@kestrel.twibright.com>
In-Reply-To: <20050517192209.GB19373@kestrel.twibright.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505172356.45232.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 23:22, Karel Kulhavy wrote:
> > >       Size of downloaded files: 1,514 kB
> > >       Homepage:    http://docbook.sourceforge.net/
> > >       Description: XSL Stylesheets for Docbook
> > >       License:     || ( as-is BSD )
> > > 
> > > Is this a bug in Linux make htmldocs?
> > 
> > It sounds more like you are missing a package.
> > 
> > In Debian it's called "docbook-utils", I don't know whether it has the 
> > same name in Gentoo.
> 
> gentoo doesn't have docbook-utils. How do I compile linux kernel
> documentations on gentoo?

OK, once again...

1. Get 2.6.12-rc4 already.
2. # emerge xmlto

> And btw why doesn't README or the error message that docbook-utils
> package is required?

Latest Documentation/Changes says:

	DocBook Stylesheets
	-------------------
	o  <http://nwalsh.com/docbook/dsssl/>

	XMLTO XSLT Frontend
	-------------------
	o  <http://cyberelk.net/tim/xmlto/>

Not enough?
