Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTEOWZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTEOWZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:25:07 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:29957 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S264262AbTEOWZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:25:06 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net, Jeff.Wiedemeier@hp.com
In-Reply-To: <16067.47444.422275.965510@napali.hpl.hp.com>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	 <1052653415.12338.159.camel@thor>
	 <16062.37308.611438.5934@napali.hpl.hp.com>
	 <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor>
	 <16063.60859.712283.537570@napali.hpl.hp.com>
	 <1052768911.10752.268.camel@thor>
	 <16064.453.497373.127754@napali.hpl.hp.com>
	 <1052774487.10750.294.camel@thor>
	 <16064.5964.342357.501507@napali.hpl.hp.com>
	 <1052786080.10763.310.camel@thor>
	 <16064.41491.952068.159814@napali.hpl.hp.com>
	 <1052921284.18105.168.camel@thor>
	 <16067.47444.422275.965510@napali.hpl.hp.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1053038272.1354.56.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 16 May 2003 00:37:52 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 17:59, David Mosberger wrote:
> 
> In regards to the Alpha platform: Jeff Wiedemeier was able to get things
> to work after applying the attached small patch.  He says:
> 
>   What was happening is that the offset was a system-relative
>   representation of the address and the (agpmem->bound) was
>   bus-relative, so it couldn't find the right agpmem.
> 
>   This patch makes the offset bus-relative before the scan (and with
>   this patch, DRI/DRM is working on a Marvel...)
> 
> If it looks OK to you, can you add it?

Sure, thanks.

http://www.penguinppc.org/~daenzer/DRI/drm-cant_use_aperture.diff

is more or less what I'd like to commit. Comments appreciated.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

