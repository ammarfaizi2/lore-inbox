Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288138AbSACCZ2>; Wed, 2 Jan 2002 21:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288137AbSACCZS>; Wed, 2 Jan 2002 21:25:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:1943 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S288138AbSACCZG>; Wed, 2 Jan 2002 21:25:06 -0500
Message-ID: <3C33C100.3070808@videotron.ca>
Date: Wed, 02 Jan 2002 21:25:04 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <000701c193f6$4ca368a0$6800000a@brownell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>
>The classic question is whether the same thing happens when you
>make your system use the "uhci" driver instead of "usb-uhci".  If the
>symptom is hang on rmmod, then rmmodding a different module
>may well make a difference.
>
It works great with uhci! Thanks a lot! I guess it points to a serious 
bug in usb-uhci?

Thanks to everyone

Roger


