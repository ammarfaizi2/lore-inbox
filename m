Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136066AbREGI6w>; Mon, 7 May 2001 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbREGI6m>; Mon, 7 May 2001 04:58:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:39156 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136049AbREGI6d>; Mon, 7 May 2001 04:58:33 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AF65FB3.777461BA@TeraPort.de> 
In-Reply-To: <3AF65FB3.777461BA@TeraPort.de>  <E14vFZb-0005GA-00@the-village.bc.nu> 
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Solved ?] Re: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 May 2001 09:58:00 +0100
Message-ID: <1870.989225880@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin.Knoblauch@TeraPort.de said:
> 
>   I am not sure whether this should be closed alltogether. Maybe
> i82365 was not the proper choice for my hardware in the first place.
> Anyway, the module seems to be retired as of 2.4.3-ac10/ac11. Maybe a
> hint should go into the changes document. 

i82365 is for use only on PCMCIA bridges, not CardBus. It should not be 
'retired' but should probably have the config option renamed to prevent 
confusion.

--
dwmw2


