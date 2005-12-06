Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVLFMUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVLFMUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVLFMUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:20:11 -0500
Received: from ns.firmix.at ([62.141.48.66]:42654 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964968AbVLFMUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:20:09 -0500
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
From: Bernd Petrovitsch <bernd@firmix.at>
To: David Engraf <engraf.david@netcom-sicherheitstechnik.de>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
In-Reply-To: <000001c5fa57$797051b0$0a016696@EW10>
References: <000001c5fa57$797051b0$0a016696@EW10>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 06 Dec 2005 13:13:22 +0100
Message-Id: <1133871202.3664.34.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 12:23 +0100, David Engraf wrote:
> > On Tue, 2005-12-06 at 11:36 +0100, David Engraf wrote:
[.../9
> > 3) wouldn't it be better to expose a wallclock time thing which
> >    has a constant unit of time between all kernels?
> 
> What is it?
> 
> 
> > (and.. wait.. isn't that called gettimeofday() )
> Not really gettimeofday is based on the date and time, but what if the user
> changes the date, the counter would also change.

man 2 times
And use the returned value.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

