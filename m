Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKCYo>; Wed, 10 Jan 2001 21:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRAKCYe>; Wed, 10 Jan 2001 21:24:34 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:55303 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129431AbRAKCYQ>; Wed, 10 Jan 2001 21:24:16 -0500
Date: Wed, 10 Jan 2001 20:24:14 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Micah Gorrell <angelcode@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poll and Select not scaling
Message-ID: <20010110202414.B23536@ganymede.isdn.uiuc.edu>
In-Reply-To: <000401c07b5c$08d924b0$9b2f4189@angelw2k>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <000401c07b5c$08d924b0$9b2f4189@angelw2k>; from angelcode@myrealbox.com on Wed, Jan 10, 2001 at 04:21:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Micah Gorrell:
} If I am asking this in the wrong place I apoligize in advace.  Please let me
} know where the correct forum would be.
} 
} 
} I have been trying to increase the scalabilty of an email server that has
} been ported to Linux.  It was originally written for Netware, and there we
} are able to provide over 30,000 connections at any given time.  On Linux
} however select stops working after the first 1024 connections.  I have
} changed include/linux/fs.h and updated NR_FILE to be 81920.  In test
} applications I have been able to create well over 30,000 connections but I
} am unable to do either a select or a poll on them.  Does any one know what I
} can do to fix this?
} 
Hi Micah,

Which kernel version are you using?

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
