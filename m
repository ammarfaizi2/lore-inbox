Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273893AbRIXMso>; Mon, 24 Sep 2001 08:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273894AbRIXMse>; Mon, 24 Sep 2001 08:48:34 -0400
Received: from t2.redhat.com ([199.183.24.243]:51707 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S273893AbRIXMsY>; Mon, 24 Sep 2001 08:48:24 -0400
Message-ID: <3BAF2BAD.AB574191@redhat.com>
Date: Mon, 24 Sep 2001 13:48:45 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kim Yong Il <nalabi@formail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q Logis ioports bug .....
In-Reply-To: <200109241240.f8OCeor06508@mail.wowlinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Yong Il wrote:
> 
> 4000-40ff : Q Logic ISP2200
>   4000-40fe : aa
> 
> 4000-40fe: aa <----- bug?????
> 

> 4000-40ff : Q Logic ISP2200
>   4000-40fe : aa

Supid qlogic driver bug; it allocates the name to register on the
stack....
