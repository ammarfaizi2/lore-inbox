Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDAIFO>; Sun, 1 Apr 2001 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132045AbRDAIEy>; Sun, 1 Apr 2001 04:04:54 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:64527 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132044AbRDAIEo>; Sun, 1 Apr 2001 04:04:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nikolas Zimmermann <wildfox@kde.org>
To: linux-kernel@vger.kernel.org
Subject: Re: w9966cf v4l driver homepage
Date: Sun, 1 Apr 2001 10:03:31 +0200
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <14jcqA-0jNLN2C@fmrl07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 April 2001 02:16, Jakob Kemi wrote:
> The w9966cf webcam v4l driver now has a homepage:
 > http://hem.fyristorg.com/mogul/w9966.html
 >

 Hi Jakob,
 
i've looked at your sources and i wonder
 why you use "return _RGB_ or _YUV_ data in
 read() mode"....
 better find use VIDIOCSPICT to find out what
 the program wants
 YUV...or .. RGB
 then have an internal video_picture
 and change the palette in there
 
then in your read() function
 simply query the cam->vpic.palette
 and decide wheter to read YUV or RGB
 
Bye
  Bye
   Niko
 
-- 
Nikolas Zimmermann
wildfox@kde.org
