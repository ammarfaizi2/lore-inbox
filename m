Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135281AbRDZKoN>; Thu, 26 Apr 2001 06:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRDZKny>; Thu, 26 Apr 2001 06:43:54 -0400
Received: from [213.97.137.182] ([213.97.137.182]:6660 "HELO pp.com")
	by vger.kernel.org with SMTP id <S135281AbRDZKne>;
	Thu, 26 Apr 2001 06:43:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eduardo =?iso-8859-1?q?Cort=E9s?= <educm@airtel.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: file size > 2gb
Date: Thu, 26 Apr 2001 12:41:11 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042612411100.00850@TheBeast>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I try to generate a big file with a kernel 2.4.2, and I can do it, but when I 
do ls -l, rm file, o something else with the file, I receive
# ls -l
ls: filename: Value too large for defined data type

I reboot with my old kernel, 2.2.18, and I can ls the file, renove it, etc... 
I can see that the created file is bigger than 2gb (the last I generate was 
2.7 gb). what happen? why I cannot ls the file with 2.4 and I can with 2.2?

I need files bigger than 2 gb, what can I do?
thanks. 
