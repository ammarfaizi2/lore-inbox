Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSKGPzD>; Thu, 7 Nov 2002 10:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSKGPzD>; Thu, 7 Nov 2002 10:55:03 -0500
Received: from 205-158-62-95.outblaze.com ([205.158.62.95]:32921 "HELO
	ws3-5.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261322AbSKGPzB>; Thu, 7 Nov 2002 10:55:01 -0500
Message-ID: <20021107160136.21804.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2002 11:01:36 -0500
Subject: Re: [2.4.19] read(2) and page aligned buffers (forget it, missing
    lseek)
X-Originating-Ip: 172.190.193.174
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forget it, my error.

What is it that you don't need when mmap()ing
a real file? You don't need to lseek()back
to the beginning after reading enough of it to
look at the magic string (which happened in between
the open() and the call to gethash().

Thanks for your time in responding to or
filtering out this non-kernel error.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Single & ready to mingle? lavalife.com:  Where singles click. Free to Search!
http://www.lavalife.com/mailcom.epl?a=2116

