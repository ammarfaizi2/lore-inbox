Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJYBwX>; Thu, 24 Oct 2002 21:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbSJYBwW>; Thu, 24 Oct 2002 21:52:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50438 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261242AbSJYBwW>;
	Thu, 24 Oct 2002 21:52:22 -0400
Message-ID: <3DB8A53E.8060502@pobox.com>
Date: Thu, 24 Oct 2002 21:58:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: Corey Minyard <cminyard@mvista.com>, dipankar@gamebox.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 6 - "Well I thought the
 last one was ready"
References: <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB85213.4020509@mvista.com> <20021024202910.GA16192@compsoc.man.ac.uk> <3DB89CD9.5090409@mvista.com> <20021025013952.GA34678@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Thu, Oct 24, 2002 at 08:22:33PM -0500, Corey Minyard wrote:
>
>  
>
>>http://home.attbi.com/~minyard/linux-nmi-v6.diff.
>>    
>>
>
>                case NOTIFY_DONE:
>                default:
>                }
>
>This needs to be :
>
>		case NOTIFY_DONE:
>		default:;
>		}
>
>or later gcc's whine.
>
or the even-more-readable:

    default: /* do nothing */
        break;



