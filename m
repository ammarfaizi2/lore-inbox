Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVFZBmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFZBmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 21:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVFZBmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 21:42:33 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:48082 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261505AbVFZBma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 21:42:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dYr/0ge2eE4EZonMLKW6+qQct+MCKhbA9eW3HCffFqtVGhkcZMH49/j1NUZytOnUxmky8nCqCMtW7XSMdIWEHni3hPymZ9dmO0A+/czoOPcol6TyUHGbLETyRGsJtwXfHFl2NN+HmpESS7mU7r3ApEd12sLOUYJw3gFaQAvIjqo=
Message-ID: <21d7e99705062518422178eb67@mail.gmail.com>
Date: Sun, 26 Jun 2005 11:42:30 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: "Garst R. Reese" <garstr@isn.net>
Subject: Re: ATI Radeon xpress 200M
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42BD9A67.3090303@isn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42BD9A67.3090303@isn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can any tell me if this grapics card is supported with the radeon
> module, and which 2.6.xx kernel would be required? I'm trying to get it
> running on a Compaq R4000, with no success.
> 
> pls cc me.
> 

The radeon kernel module is only used for 3D support features, at the
moment there isn't any real support for r300 class cards for 3D (ether
fglrx from ATI, or r300.sf.net).

For 2D support you don't need any kernel drivers.. X should support
your card but you might have to set the ChipID ... but that is OT for
lkml....

Dave.
