Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRIVQ23>; Sat, 22 Sep 2001 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRIVQ2U>; Sat, 22 Sep 2001 12:28:20 -0400
Received: from server1200.net ([209.239.42.69]:23558 "EHLO server1200.net")
	by vger.kernel.org with ESMTP id <S271809AbRIVQ2J>;
	Sat, 22 Sep 2001 12:28:09 -0400
Date: Sat, 22 Sep 2001 12:33:24 -0400
From: "Ian D . Stewart" <idstewart@compuvative.com>
To: Stephen Torri <storri@ameritech.net>
Cc: "D . Stimits" <stimits@idcomm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial Ports
Message-ID: <20010922123324.A4677@localhost.ameritech.net>
In-Reply-To: <3B96C783.8BC8E29B@idcomm.com> <Pine.LNX.4.33.0109061624320.1443-100000@base.torri.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0109061624320.1443-100000@base.torri.linux>; from storri@ameritech.net on Thu, Sep 06, 2001 at 16:27:06 -0400
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.09.06 16:27:06 -0400 Stephen Torri wrote:

> 
> I have noticed that serial ports change IRQ to either 3 or 4. There is no
> reason for this behavior. I have created a perl script to create a log
> containing the irqs assigned and their ioports. Is there anything else I
> could log that might unmask the problem?
> 
> So far if the serials are assigned to IRQ 4 then the sync with the palm
> pilot doesn't work (/dev/pilot = /dev/ttyS0). If its IRQ 3 then it does.

As I understand it, /dev/ttyS0-3 are set to industry standard values on
startup (they are not probed).  The values can be changed using the
command-line utility setserial.  You can specify non-standard values in an
rc.serial conf file which will be read on startup.

The setserial manpage covers this is some detail.


HTH,
Ian

-- 
"God may have mercy.  We will not."
--Senator John S. McCain (R-AZ)

