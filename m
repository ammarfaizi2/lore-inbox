Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTBCEbB>; Sun, 2 Feb 2003 23:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBCEbB>; Sun, 2 Feb 2003 23:31:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266038AbTBCEbA>;
	Sun, 2 Feb 2003 23:31:00 -0500
Message-ID: <3E3DF2A5.7060504@pobox.com>
Date: Sun, 02 Feb 2003 23:40:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Williams <fido@tcob1.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Comm 3CR990-TX-97 NIC
References: <MSGID_1=3a11=2f203_3e3d708a@fidonet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Williams wrote:
> Originally to: All
> 
> Hello,
> 
> Has anyone ever got 3com's 3cr990 Nic card to work in Linux. If, so how? What 
> driver did you use, and where to find it. BTW, this is the card with '3 DES 168 
> bit encryption' and it has onboard the 3xp processor. Any help will be 
> appreciated.


There are two Linux drivers for it.  One is 3com's, a bit shoddy but Ion 
B. did a nice job of cleaning it up.  The other is David Dillow's; DD's 
driver looks really good, supports NAPI and all sorts of bells and whistles.

I'm currently waiting to see if DD's driver gets the stamp of approval 
from a certain legal department.  If that doesn't come through soon, the 
"backup plan" kicks into effect, and Ion's cleanup of 3com's driver gets 
merged.

Neither driver hooks into the 2.5.x CryptoAPI, AFAIK...

	Jeff



