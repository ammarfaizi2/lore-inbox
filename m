Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRFUHVy>; Thu, 21 Jun 2001 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264923AbRFUHVo>; Thu, 21 Jun 2001 03:21:44 -0400
Received: from typhoon.mail.pipex.net ([158.43.128.27]:5073 "HELO
	typhoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S264883AbRFUHVf>; Thu, 21 Jun 2001 03:21:35 -0400
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@no.spam.dial.pipex.com (Trevor Hemsley)
Date: Thu, 21 Jun 2001 08:15:10
Subject: Re: aic7xxx oops with 2.4.5-ac13
X-Mailer: ProNews/2 V1.51.ib104
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010621072142Z264883-17720+6265@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001 03:05:02, "Jeff V. Merkey" 
<jmerkey@vger.timpanogas.org> wrote:

> Ditto.  I am also seeing this oops calling the sg driver for a 
> robotic tape library, and it also seems to happen on 2.4.4.

In my case it appears that it was the symptom of severe bus problems. 
About 5 minutes after I posted the initial report I discovered that 
the cable from the back of the Nikon to the MO drive had fallen off so
the bus was running unterminated. Replugging it fixed teh bus error 
and the oops. 

Looks like error handling is all fscked up...

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

