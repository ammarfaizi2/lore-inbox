Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRIOBqN>; Fri, 14 Sep 2001 21:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRIOBqD>; Fri, 14 Sep 2001 21:46:03 -0400
Received: from lego.zianet.com ([204.134.124.54]:51727 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S271719AbRIOBpp>;
	Fri, 14 Sep 2001 21:45:45 -0400
Message-ID: <3BA2B1DA.8050208@zianet.com>
Date: Fri, 14 Sep 2001 19:41:46 -0600
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010910
X-Accept-Language: en-us
MIME-Version: 1.0
To: DevilKin@gmx.net
CC: linux-kernel@vger.kernel.org
Subject: Re: AGP Bridge support for AMD 761
In-Reply-To: <20010914214120.039EE21712C@tartarus.telenet-ops.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevilKin wrote:

>Hello all...
>
>I've recently bought a new mobo, the Abit KG7-Raid, and I've run into some trouble trying to get the agpgart to work correctly. Everytime I load it 
>on kernel 2.4.9 (nonpatched, straigt from the tarball) I get messages like 'Unsupported chipset; try try_unsupported' (or smthing, not entirely
>sure about the msg anymore since I'm not on that PC right now). I've tried what it advices, but still it keeps on giving that error.
>
>Anyone got a clue?
>
>Thanks,
>
>Devil
>
Well, do what its telling you.  Either append 'agp_try_unsupported' to 
lilo or use it as an option on modules.

Ex: modprobe agpgart agp_try_unsupported=1

Steve


