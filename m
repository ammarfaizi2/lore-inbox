Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSA1RiE>; Mon, 28 Jan 2002 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289294AbSA1Rhy>; Mon, 28 Jan 2002 12:37:54 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:5313 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289293AbSA1Rhh>; Mon, 28 Jan 2002 12:37:37 -0500
Message-ID: <3C558BC0.5050700@wanadoo.fr>
Date: Mon, 28 Jan 2002 18:34:56 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 fs corruption and usb devices
In-Reply-To: <Pine.LNX.4.44.0201281631110.20095-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
 >> Warning (Oops_read): Code line not seen, dumping what data is
 >> available
 >>
 >
 > You need to get the whole oops output...

Where have you seen it's an oops. have you read my message ?

 >
 >>>> EIP; c0140754 <inode_change_ok+24/128>   <=====
 >>>>
 >> Trace; d08b959c <[speedtch]udsl_usb_driver+1c/40> Trace; d089ea1c
 >> <[usbcore]free_inode+7c/84> Trace; d089f870
 >> <[usbcore]usbdevfs_remove_device+30/d8>
 >>
 >
 > Isn't that a proprietory driver you have there? Who knows what lurks
 > in the inner depths of that cruft, i'd ask you to reproduce it
 > without loading that driver, but then that would be pointless for
 > your situation. I suggest you take it up with Alcatel...

Why? The problem is solved by the diff in ext2 code in 2.4.18-pre7
(have you read my message ?)

What i would like to know is why the corruption of the ext2 root fs with 
  2.4.18-pre6 in only visible by the usb drivers. is it pure chance ?


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

