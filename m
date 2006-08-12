Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWHLO2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWHLO2V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWHLO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:28:20 -0400
Received: from dvhart.com ([64.146.134.43]:56774 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932523AbWHLO2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:28:20 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: bootsplash integration
Date: Sat, 12 Aug 2006 07:27:58 -0700
User-Agent: KMail/1.9.1
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>,
       Steve Barnhart <stb52988@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com> <44DCB95B.4060101@tremplin-utc.net> <1155317729.24077.110.camel@localhost.localdomain>
In-Reply-To: <1155317729.24077.110.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608120727.58446.vernux@us.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 10:35, Alan Cox wrote:
> Ar Gwe, 2006-08-11 am 19:07 +0200, ysgrifennodd Eric Piel:
> > I just wonder if one can also put background pictures on the TTY only
> > from user-space...
>
> Currently only easily via X11 because the knowledge of the overlay and
> YUV/RGB scaler engines is in X not in the kernel.

mplayer knows how to play to a framebuffer on the console without X.  So this 
is possible.  I have played a movie on my framebuffer before.  If mplayer can 
do it, splashy should be able to do it as well.  Use a native framebuffer if 
your card supports that or VESA if it doesn't.  This is definitely something 
that belongs in userspace, not in the kernel.

--Vernon

> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
