Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbRE1QRI>; Mon, 28 May 2001 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbRE1QQ7>; Mon, 28 May 2001 12:16:59 -0400
Received: from smtp5vepub.gte.net ([206.46.170.26]:6971 "EHLO
	smtp5ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S263086AbRE1QQr>; Mon, 28 May 2001 12:16:47 -0400
Message-ID: <3B1279E5.46B1FBD7@neuronet.pitt.edu>
Date: Mon, 28 May 2001 12:16:37 -0400
From: Rafael Herrera <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mythos <papadako@csd.uoc.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
In-Reply-To: <Pine.GSO.4.33.0105281141320.24932-100000@iridanos.csd.uch.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem reported here before was switching from X to the console.
The video signal would be lost and the computer would hang.

The responses pointed out the it was the switch of video modes; XFree
would change the internals of the video controller which the frame
buffer could not cope with. You were part of the discussion. The matrox
drivers have not changed since april, so its interactions with the frame
buffer may be still buggy. 
-- 
     Rafael
