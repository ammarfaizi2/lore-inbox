Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbREBPqP>; Wed, 2 May 2001 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135595AbREBPqF>; Wed, 2 May 2001 11:46:05 -0400
Received: from mail.ureach.com ([63.150.151.36]:19983 "EHLO ureach.com")
	by vger.kernel.org with ESMTP id <S135590AbREBPpt>;
	Wed, 2 May 2001 11:45:49 -0400
Date: Wed, 2 May 2001 11:45:48 -0400
Message-Id: <200105021545.LAA18440@www23.ureach.com>
To: linux-kernel@vger.kernel.org
From: Kapish K <kapish@ureach.com>
Reply-to: <kapish@ureach.com>
Subject: nfs performance at high loads
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-vsuite-type: e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!!
    Well... thanks for all the suggestions, but we might need to 
stick with 2.4.2 for various other dependencies, but, I have a 
surprising thing to report on the observations. I tried the 
zero-copy patch on 2.4.0, and it seemed to help in solving the 
memory allocation problem, and also did have some decent 
throughput and response time ( around 5 milliseconcds or so ).
But, with 2.4.2, its horrible!!! Yes, we don't see any memory 
allocation problems, but nfs seems to have been really screwed 
up or something. I haven't had the chance to look at the code ( 
should try to do so soon ), but does anybody have any idea of 
lurking bugs in this area?? This is totally unacceptable. We see 
response times of 80 milliseconds!!! There is something really 
gone wrong here...
any ideas??
Thanks 

________________________________________________
Get your own "800" number
Voicemail, fax, email, and a lot more
http://www.ureach.com/reg/tag
