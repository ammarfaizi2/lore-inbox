Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSEEQAd>; Sun, 5 May 2002 12:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSEEQAc>; Sun, 5 May 2002 12:00:32 -0400
Received: from smtp02.web.de ([217.72.192.151]:40990 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S313157AbSEEQAZ>;
	Sun, 5 May 2002 12:00:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Huber <sebastian-huber@web.de>
To: linux-kernel@vger.kernel.org
Subject: modversion.h improvement suggestion
Date: Sun, 5 May 2002 18:00:51 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174OQu-0007H2-00@smtp.web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I tried to compile a device driver module and got the error that 
'modversion.h' cannot be found. My first questions were:
	Are the include paths ok?
	Do the maintainer now what he or she is doing?
	Uses this driver code obsolete kernel stuff?
	Has SuSE forgotten something to install?
Then I started a google search for 'modversion.h' and noticed that this was a 
common problem. And after a while I found the solution -> modversion.h is an 
automatically generated file.

So what about a default modversion.h file:
/* This is an automatically generated file. Do not edit it. */
#error You have not generated the module versions. You have to ...

This hint may save some time for those who are not so fit in kernel issues.

Ciao
	Sebastian


PS:
I'm not a member of this mailing list, so please cc me mails related to that 
subject.
