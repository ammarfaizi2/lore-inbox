Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbWAHWIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbWAHWIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWAHWIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:08:38 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:54068 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932776AbWAHWIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:08:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=b6oV/a1oCseMYZkHNskixddnzb/CfEXc8eMl6vfo4rZyAH+3nDB8FWZNIbj3dVRbI8W3dEUlVcVCZoeIZEybGddVW885MfNMvHClgXPxHI5n9vnJk9Lv74jn8wrHaeK3ZryuajOJeLopV/NMFU+oKeyyf93aBFaEHnte9t1t/V4=
Date: Mon, 9 Jan 2006 01:25:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
Message-ID: <20060108222529.GC7488@mipter.zuzino.mipt.ru>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:46:22PM +0100, Jan Engelhardt wrote:
> > iocharset=name	Character set to use for converting from Unicode to
> > 		ASCII.  The default is to do no conversion.  Use
> >-		iocharset=utf8 for UTF8 translations.  This requires
> >+		iocharset=utf8 for UTF-8 translations.  This requires
> > 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
>
> If you are really nitpicky about the "-", then it should also be
> "iocharset=utf-8" (and whereever else). Or what's the real purpose of
> adding the dashes in only half of the places, then?

I don't want to be shot by everyone who has "iocharset=utf8" in
/etc/fstab.

