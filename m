Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSFDUis>; Tue, 4 Jun 2002 16:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSFDUir>; Tue, 4 Jun 2002 16:38:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316728AbSFDUir>;
	Tue, 4 Jun 2002 16:38:47 -0400
Message-ID: <3CFD24C6.7050107@mandrakesoft.com>
Date: Tue, 04 Jun 2002 16:36:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
In-Reply-To: <000101c20bd5$b8f24560$010b10ac@sbp.uptime.at> <Pine.LNX.4.33.0206040749530.654-100000@geena.pdx.osdl.net> <20020604142317.B18238@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:

>On Tue, Jun 04, 2002 at 08:19:49AM -0700, Patrick Mochel wrote:
>  
>
>>The short of it: 2.5.19 introduced a struct bus_type that describes each
>>bus type in the system.
>>    
>>
>
>Which immediately collided with 'static struct bus_type {...}'
>hidden in drivers/net/tulip/de4x5.c and, as result, the later does
>not compile anymore.  These two "bus_types" are quite dissimilar. :-)
>  
>


FWIW that s/bus_type/de4x5_bus_type/ patch was applied to 2.5.20 (and to 
2.4.x too, even)

    Jeff




