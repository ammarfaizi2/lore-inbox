Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbRERTWp>; Fri, 18 May 2001 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRERTWf>; Fri, 18 May 2001 15:22:35 -0400
Received: from WARSL401PIP7.highway.telekom.at ([195.3.96.115]:49246 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S261462AbRERTW1>;
	Fri, 18 May 2001 15:22:27 -0400
Date: Fri, 18 May 2001 21:02:26 +0200
From: Eduard Hasenleithner <eduardh@aon.at>
To: linux-kernel@vger.kernel.org
Subject: DVD blockdevice buffers
Message-ID: <20010518210226.A7147@moserv.hasi>
Mail-Followup-To: Eduard Hasenleithner <eduardh@aon.at>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with the buffering mechanism of my blockdevice,
namely a ide_scsi DVD-ROM drive. After inserting a DVD and reading
data linearly from the DVD, an excessive amount of buffer memory gets
allocated.

This can easily be reproduced with
	cat /dev/sr0 > /dev/null

Remember, nearly the same task is carried out when playing a DVD.

As a result the system performance goes down. I'm still able to use
my applications, but es every single piece of unused memory is swapped
out, and swapping in costs a certain amount of time.

So, what wents wrong? I tried to find some information on this with
google and geocrawler, but i didn't have a success :(

Kernel: linux-2.4.4

hoping for some tips ...

-- 
Eduard Hasenleithner
student of
Salzburg University of Applied Sciences and Technologies
