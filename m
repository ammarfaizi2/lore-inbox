Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263503AbTCNUuK>; Fri, 14 Mar 2003 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263507AbTCNUuK>; Fri, 14 Mar 2003 15:50:10 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3489 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263503AbTCNUuJ>; Fri, 14 Mar 2003 15:50:09 -0500
Message-ID: <3E72413E.5090906@nortelnetworks.com>
Date: Fri, 14 Mar 2003 15:53:18 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Kernel setup() and initrd problems
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu> <b4t9i6$eon$1@cesium.transmeta.com> <3E722D31.6050702@nortelnetworks.com> <3E7230D2.7010309@zytor.com> <3E7235B7.5050407@nortelnetworks.com> <3E723ECD.8010000@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Chris Friesen wrote:

>>Maybe I'm just confused.

> I think so.
>
> The way to get around the historical baggage is to tell the kernel that
> the initrd is a "permanent" initrd by using the "root=/dev/ram0"
> command-line option.  This has the side effect of bypassing all the
> initrd historical crap and instead spawning /sbin/init using PID 1, like
> any other system would do.  Now you can just pivot and "exec /sbin/init"
> like you should be.

Thanks for that excellent explanation.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

