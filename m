Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272148AbRHVWYd>; Wed, 22 Aug 2001 18:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272149AbRHVWYV>; Wed, 22 Aug 2001 18:24:21 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:34545 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S272148AbRHVWYM>; Wed, 22 Aug 2001 18:24:12 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC2171@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: tasklet question...
Date: Wed, 22 Aug 2001 15:24:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

If iam using tasklets for deferred processing, and after some threashold
processing in the tasklet 
would like to reschedule tasklet again. will the following work

tasklet_function()
{
	more_processing = DeferredProcessing()
            if (more_processing)
	       tasklet_schedule() // this will schedule the same tasklet.
}

is the above legal.


ashokr
