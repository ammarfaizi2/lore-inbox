Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSE0KPT>; Mon, 27 May 2002 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSE0KPS>; Mon, 27 May 2002 06:15:18 -0400
Received: from [195.77.234.5] ([195.77.234.5]:22803 "EHLO ntdes.cirsa.com")
	by vger.kernel.org with ESMTP id <S316567AbSE0KPS>;
	Mon, 27 May 2002 06:15:18 -0400
Subject: Init process and threads
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC3D6597E.4808C273-ONC1256BC6.0037ABC1@cirsa.com>
From: jorgefm@cirsa.com
Date: Mon, 27 May 2002 12:16:11 +0200
X-MIMETrack: Serialize by Router on ntdes/DESAR(Release 5.0.8 |June 18, 2001) at 27/05/2002
 12:16:26
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I have a little question about creating linux threads inside the process
init.
Is there some limitation in the clone() function when the parent id is 1?
I was trying the 'pthread_create()' call in the init process code but it
nevers returns.
The same code in a child process, in the same module after the fork(), runs
ok.
I used the linux kernel v2.4.19-pre8.

Could you CC the answer/comments to my personnal email, please?

Thanks for your comments,
Jorge Fernandez
UNIDESA

