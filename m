Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRITLVO>; Thu, 20 Sep 2001 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274425AbRITLVF>; Thu, 20 Sep 2001 07:21:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63505 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274424AbRITLUv>; Thu, 20 Sep 2001 07:20:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: broken VM in 2.4.10-pre9
Date: Thu, 20 Sep 2001 13:28:31 +0200
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rfuller@nsisoftware.com (Rob Fuller),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <E15jpRy-0003yt-00@the-village.bc.nu>
In-Reply-To: <E15jpRy-0003yt-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920112110Z16256-2757+869@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 20, 2001 12:04 am, Alan Cox wrote:
> Reverse mappings make linear aging easier to do but are not critical (we
> can walk all physical pages via the page map array). 

But you can't pick up the referenced bit that way, so no up aging, only
down.

--
Daniel
