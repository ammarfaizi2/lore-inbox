Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRAETfD>; Fri, 5 Jan 2001 14:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAETex>; Fri, 5 Jan 2001 14:34:53 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:59401 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S130993AbRAETeg>; Fri, 5 Jan 2001 14:34:36 -0500
Date: Fri, 5 Jan 2001 13:34:25 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Miles Lane <miles@megapathdsl.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac1
Message-ID: <20010105133425.D13010@ganymede.isdn.uiuc.edu>
In-Reply-To: <3A556195.5090902@megapathdsl.net> <20334.978674744@kao2.melbourne.sgi.com> <20010105003107.C19392@ganymede.isdn.uiuc.edu> <3A5579CD.6050708@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A5579CD.6050708@megapathdsl.net>; from miles@megapathdsl.net on Thu, Jan 04, 2001 at 11:37:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Miles Lane:
} Bill Wendling wrote:
} 
} > Also sprach Keith Owens:
} > } On Thu, 04 Jan 2001 21:54:29 -0800, 
} > } Miles Lane <miles@megapathdsl.net> wrote:
} > } >make[4]: Entering directory `/usr/src/linux/drivers/acpi'
} > } >/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references itself (eventually).  Stop.
} > } 
} 
} > Changing that line to:
} > 
} > $(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
} > 
} > might work as well...
} 
} Seems to work here.  Thanks, Bill.
} 
Great! I just wish I knew where this line was being generated so that I
could send a patch in :).

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
