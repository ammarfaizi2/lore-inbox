Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSL0PFX>; Fri, 27 Dec 2002 10:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSL0PFX>; Fri, 27 Dec 2002 10:05:23 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:39846 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264954AbSL0PFW>; Fri, 27 Dec 2002 10:05:22 -0500
Message-ID: <20021227151332.26696.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "David Anderson" <david-ander2023@mail.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Dec 2002 10:13:32 -0500
Subject: Reading a file in the driver
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am reading some data from a file byte by byte in my driver. Although it's not a good thing to read a file in the driver I have to do it. My file is quite big can contain about 1000 lines each line containing anywhere from 0 to 500 characters. I believe carry out 500000 reads is not a good thing. 

Any suggestions on how I can improve ??

Thanks and Regards,
David
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

