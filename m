Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCCRPm>; Sun, 3 Mar 2002 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSCCRPd>; Sun, 3 Mar 2002 12:15:33 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:59608 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S287817AbSCCRPY>;
	Sun, 3 Mar 2002 12:15:24 -0500
Message-ID: <3C825A19.5070204@tmsusa.com>
Date: Sun, 03 Mar 2002 09:15:05 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: janvapan <jvp@wanadoo.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC
In-Reply-To: <3C82148E.E530824@wanadoo.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my humble experience with some hundreds
of different Linux servers, the 3c905 seems the
most trouble-free, and performs well.

The Intel adapter has potential driver issues,
although they seem to be getting resolved.

The e100 driver has the disadvantage of being
unable to work with the mii-tool commands,
but seems to work well otherwise - as long as
you don't mind trying to puzzle out whether
the card is conected at 10 or 100, full or half.

The eepro100 driver works with mii-tool, but
many have reported issues with the card dying
under heavy use and needing to be reset. Many
are using the eepro100 without problems - but
the bottom line is that nobody is seeing these
problems with the 3com cards.

YMMV of course -

Joe
 

janvapan wrote:

>What ethernet cards I should use for Linux 2.4?.
>I am looking for a NIC based on stability and performance.
>In short, Intel PRO/100 S Desktop Adapter(e100 driver) or
>3Com 10/100 3C905C-TX-M(3c59x driver) ?
>


