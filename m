Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSGBSHa>; Tue, 2 Jul 2002 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSGBSH3>; Tue, 2 Jul 2002 14:07:29 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:58777 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316895AbSGBSH3> convert rfc822-to-8bit; Tue, 2 Jul 2002 14:07:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [OKS] Module removal
Date: Tue, 2 Jul 2002 20:10:50 +0200
User-Agent: KMail/1.4.1
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20020702155319.25599.qmail@eklektix.com> <200207021807.06174.oliver@neukum.name> <20020702174831.GP20920@opus.bloom.county>
In-Reply-To: <20020702174831.GP20920@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207022010.50572.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Juli 2002 19:48 schrieb Tom Rini:
> On Tue, Jul 02, 2002 at 06:07:06PM +0200, Oliver Neukum wrote:
> > > developing drivers and such.  Aunt Tillie would no longer be able to
> > > remove modules from her kernel, but that's not likely to bother her
> > > too much...
> >
> > It would very much bother uncle John, who is in high availability.
>
> Then the HA kernel turns on the ability to still remove modules, along
> with all of the other things needed in an HA environment but not
> elsewhere.  Provided removing a module doesn't become a horribly racy,
> barely usable bit of functionality, which I hope it won't.

Either there is a race or there isn't. Such a thing is unusable on a
production system.

	Regards
		Oliver


