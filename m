Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVLEOa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVLEOa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVLEOa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:30:26 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:42061 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751373AbVLEOaZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:30:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sJuxDeqamusczGACbO2qMS9K0zZfA+9h0qUm5UFAUYPLWjMtJioOWXWZmo8/onkCLgnDfjG/ayLuUfI+g9QTdjqutFkkDEYHbDdCK13t7ITQ7M+aDtYoMC1hVagpbG2yVe0xWHZ/V43J3a0/OENgERVH/Buuhu50PqJZjPUrjvg=
Message-ID: <9611fa230512050630pca78052s9ebd5b15108ad1dc@mail.gmail.com>
Date: Mon, 5 Dec 2005 14:30:23 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <9611fa230512020449g2573ea55qd6d780b750eb773c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <20051127165733.643d5444.akpm@osdl.org>
	 <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
	 <20051129151044.7ce3ef4a.akpm@osdl.org>
	 <9611fa230512011242p526b5128ub2918a3fa48da10c@mail.gmail.com>
	 <9611fa230512020449g2573ea55qd6d780b750eb773c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 12/2/05, Tarkan Erimer <tarkane@gmail.com> wrote:
> Today, I tried 2.6.15-rc4. The result is same. Still hangs,
> Alt+sysrq+t does not respond and there is nothing related to the issue
> in syslog.
>

I also tried 2.6.15-rc5. This time things are a bit different. Still,
the bug exist.
Differently, I can do Alt+sysrq+t when hanged. It works (I can see the
sysrq t initiated message on console) now. But, The call trace events
do not appear  in syslog. Normally, it appears in syslog.


Regards
