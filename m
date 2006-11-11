Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424585AbWKKRXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424585AbWKKRXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 12:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424588AbWKKRXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 12:23:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:7838 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424585AbWKKRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 12:23:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TwDSfZ93YnGzLRYKBj9leL8ec/GLw1ZsvI50IbVZPAtXK9tRvH7Rnlesey36v4VOl3S3gIOpGL/oiSeZ0N08EB9aqvnubnoRRWXI30/dhRckLHCns41YIAAZzbO43YRZTZWw410I4RbZEKTxBKMb7GhK0o5H9S6VNcot8UApIZg=
Message-ID: <40f323d00611110923v6f094926jf2123c15a1edddc7@mail.gmail.com>
Date: Sat, 11 Nov 2006 18:23:07 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Christian Kujau" <evil@g-house.de>
Subject: Re: OOM in 2.6.19-rc*
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/06, Christian Kujau <evil@g-house.de> wrote:
> Hello,
>
> a few days ago I upgraded my desktop machine (x86_64) to ubuntu/edgy
> thus completely changing the userland. Since I'm using kernel.org
> kernels I upgraded to a current kernel as well (2.6.19-rc4-git from Nov
> 4 and 2.6.19-rc4-mm2). Now, while working under X11, probably reading
> email, all of a sudden the machine was not responsible any more and the
> disk was spinning like wild. The desktop applet showed all swap being
> used up then the display froze too and ~5 min later the machine came
> back with the gnome-login screen: it had not rebooted but ran OOM and
> several apps got killed.
>
Just a thought, do you have a swap activated ? (there is a bug in edgy
where the swap isn't mounted)

regards,

Benoit
