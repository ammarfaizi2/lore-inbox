Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262757AbSJGXyf>; Mon, 7 Oct 2002 19:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbSJGXyf>; Mon, 7 Oct 2002 19:54:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:41366 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262757AbSJGXye>;
	Mon, 7 Oct 2002 19:54:34 -0400
Subject: Re: kernelNFS(lockd) problem and patch suggestion
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFF11B71B0.8C62C31E-ON87256C4B.0083C390@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Mon, 7 Oct 2002 17:00:06 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/07/2002 18:00:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


OK I will do so...hopefully "Marcelo" is reading these postings as I do not
have his direct email.

Regards, Juan



|---------+---------------------------->
|         |           Trond Myklebust  |
|         |           <trond.myklebust@|
|         |           fys.uio.no>      |
|         |                            |
|         |           10/07/02 04:51 PM|
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                                 |
  |       cc:       linux-kernel@vger.kernel.org                                                                                 |
  |       Subject:  Re: kernelNFS(lockd) problem and patch suggestion                                                            |
  |                                                                                                                              |
  |                                                                                                                              |
  >------------------------------------------------------------------------------------------------------------------------------|



>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > After taking a look at the code I realized that the lockd
     > thread sets grace period and then goes to sleep for a long time
     > waiting for messages and the first message always gets
     > processed before checking if the grace period has completed

Please could you rediff using the '-u' option and drop the MIME
attachment thingy (See Documentation/SubmittingPatches).

Patch otherwise looks quite correct, so once the patch format is OK
then, by all means send it off to Marcelo and (if you could bang up
the same patch for 2.5.x) to Linus too.

Cheers,
  Trond



