Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271289AbRHTPaT>; Mon, 20 Aug 2001 11:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271310AbRHTP37>; Mon, 20 Aug 2001 11:29:59 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:34066 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S271307AbRHTP3s>; Mon, 20 Aug 2001 11:29:48 -0400
Message-ID: <3B812CF3.DFE7247D@delusion.de>
Date: Mon, 20 Aug 2001 17:29:55 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() says closed socket readable
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru>
		<E15Yq81-0006o8-00@shell2.shore.net> <20010820.080334.68038516.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    No, a socket that's never been connected isn't readable, hence
>    select() shouldn't be returning a value of 1 on it.
> 
> You may read without blocking, select() returns 1.
> 
> Please, fix your app.

Hello,

While we're at it - are there any plans to fix the other
select issue which was already discussed in December 2000? The
original thread can be found at:

http://uwsg.iu.edu/hypermail/linux/net/0012.2/0008.html

I realize that the behaviour doesn't violate the standards, but
as Alexey said - it's still somewhat wrong.

-Udo.
