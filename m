Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTKZSfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTKZSfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:35:16 -0500
Received: from pop.gmx.net ([213.165.64.20]:25563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264273AbTKZSfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:35:10 -0500
X-Authenticated: #524548
From: rgx <rgx@gmx.de>
To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
Subject: Re: kernel 2.4-22 won't compile...
Date: Wed, 26 Nov 2003 19:35:03 +0100
User-Agent: KMail/1.5.4
References: <200311261734.23177.rgx@gmx.de> <200311261749.12545.rgx@gmx.de> <1069870412.25657.6.camel@tweedy.ksc.nasa.gov>
In-Reply-To: <1069870412.25657.6.camel@tweedy.ksc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261935.03860.rgx@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Chiodini schrieb am Mittwoch, 26. November 2003 19:13:
> On Wed, 2003-11-26 at 11:49, rgx wrote:
> > > Did you 'make oldconfig'?
> >
> > Yes, sure :) The NLS_DEFAULT... is not defined for some reason...
> > I could replace it with the needed content in the source code if I
> > knew its format...
>
> Sorry, had to ask.
>
> My 2.4.20 .config defines:
>
> CONFIG_NLS_DEFAULT="iso8859-1"

yes, this is in my .config file, too, but for gcc it has to be converted 
to a
#define CONFIG_NLS_DEFAULT <something> line - and I think that it 
shouldn't be just a string there...

