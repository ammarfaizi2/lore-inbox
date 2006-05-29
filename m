Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWE2Vv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWE2Vv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWE2Vv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:51:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:58323 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751325AbWE2Vv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:51:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VYzMyxRS1l4fblgmJYgUTBoPYMqonBRRq4IBAKuM6pJ+Rr+0lNchXUZz+sUpbvPkbxxd0VaxcWsv2homHp5MVGK6gMkOzEoD+Qwkd05U2c+6sumq2JL4r8sALBVyiPTXA0HUH+gm+Qz6xXvVfbX9epslfIpg6H+ygCFuaVo2qzs=
Message-ID: <9a8748490605291451y2c6c2a8bs621ada64fafd6a62@mail.gmail.com>
Date: Mon, 29 May 2006 23:51:27 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: /sys/class/net/eth?/carrier and uevents
Cc: "=?ISO-8859-1?Q?Jo=E3o_Luis_Meloni_Assirati?=" 
	<assirati@nonada.if.usp.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1148938395.3291.104.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605291807.42725.assirati@nonada.if.usp.br>
	 <9a8748490605291429h32f67b53k757d6e4a0cec7675@mail.gmail.com>
	 <1148938395.3291.104.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> >
> > I added the 'carrier' attribute initially but never considered udev at
> > the time. But I can certainly see how it could be useful.
> > I'll take a look at adding a hotplug event when I get some spare time
> > (probably some time next week) - or perhaps someone else will beat me
> > to it :)
>
> there is a netlink event already though... is this really worth the
> duplication?
>

Dunno, perhaps not. Have not looked at it yet. If it's simple to add
and there won't be any confusion for userspace as to what event to
react to, then it might be a nice little thing to have.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
