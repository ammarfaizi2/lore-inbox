Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSGBRqK>; Tue, 2 Jul 2002 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGBRqJ>; Tue, 2 Jul 2002 13:46:09 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25772
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316831AbSGBRqJ>; Tue, 2 Jul 2002 13:46:09 -0400
Date: Tue, 2 Jul 2002 10:48:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oliver Neukum <oliver@neukum.name>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020702174831.GP20920@opus.bloom.county>
References: <20020702155319.25599.qmail@eklektix.com> <200207021807.06174.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207021807.06174.oliver@neukum.name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 06:07:06PM +0200, Oliver Neukum wrote:

> > developing drivers and such.  Aunt Tillie would no longer be able to
> > remove modules from her kernel, but that's not likely to bother her too
> > much...
> 
> It would very much bother uncle John, who is in high availability.

Then the HA kernel turns on the ability to still remove modules, along
with all of the other things needed in an HA environment but not
elsewhere.  Provided removing a module doesn't become a horribly racy,
barely usable bit of functionality, which I hope it won't.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
