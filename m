Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933287AbWFZXme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbWFZXme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbWFZXmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:42:31 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:19286 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933154AbWFZXmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:42:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIALBtDZY3eHQ/FfbRbmRtVosl/BjBzARQrTr7jKQiB33wR62hDyNXA6PB9VDx9gAN0HBzhdnPVYijpjVhpTSszdARsHsp51TE0mlPlh+GobZJW/IBFD4/ipgwW5NU0WobGGVjPEejkB1JIjaS2VN+L8gtMrMCoTv8xhPAd24Uc=
Message-ID: <6bffcb0e0606261642q429f9f54w44f1c6580ce0c143@mail.gmail.com>
Date: Tue, 27 Jun 2006 01:42:12 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: oom-killer problem
Cc: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606270028.16346.daniel.ritz-ml@swissonline.ch>
	 <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 27 Jun 2006, Daniel Ritz wrote:
> >
> > reverting the attached patch fixes the problem...
>
> Michal, can you also confirm that just doing a simple revert of that one
> commit makes things work for you?

Yes I can confirm that.
(http://www.ussg.iu.edu/hypermail/linux/kernel/0606.3/0827.html)

>
> Sam, if I don't hear otherwise from you, and Michael confirms, I'll just
> revert it for now, and you can figure out how to fix it without breakage?
>
>                         Linus
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
