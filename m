Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRC2LhP>; Thu, 29 Mar 2001 06:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132712AbRC2LhF>; Thu, 29 Mar 2001 06:37:05 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:260 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S132708AbRC2Lgv>;
	Thu, 29 Mar 2001 06:36:51 -0500
Date: Thu, 29 Mar 2001 12:40:03 +0200
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: Hanging process
Message-ID: <20010329124003.B156@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I  did

cat /dev/zero >/dev/fd0
no space left on device (that's correct)
ps ax | grep cat
kill pid - nothing
kill -9 pid - nothing
then I repeatedly did the kill -9 , when after about half a minute it started working

What's wrong? Why was the process unkillable?

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
