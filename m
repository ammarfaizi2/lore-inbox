Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSFGVFK>; Fri, 7 Jun 2002 17:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSFGVFJ>; Fri, 7 Jun 2002 17:05:09 -0400
Received: from gremlin.ics.uci.edu ([128.195.1.70]:48267 "HELO
	gremlin.ics.uci.edu") by vger.kernel.org with SMTP
	id <S317347AbSFGVFI>; Fri, 7 Jun 2002 17:05:08 -0400
Date: Fri, 7 Jun 2002 14:05:05 -0700 (PDT)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: HDD power states + kernel
In-Reply-To: <20020607205114Z317348-22021+121@vger.kernel.org>
Message-ID: <Pine.SOL.4.20.0206071355570.16596-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i need to implement powering down of the Hard Disk in the linux kernel. i
understand that using "hdparm" i could set a timeout and power down the
HDD after a certain idle time.

but then HDD has 4 power states and instead of powering down to the lowest
power state, i would like to power down one state at a time based on
certain timeout values.  

i'm not sure where to start with this. would i have to play around with
"llrwblk.c"? and what would i have to do here in order to monitor disk
inactivity (idleness)? or should i look into APM stuff?

any help or pointers in this direction would be of great help.

thanks in advance,
mukesh

