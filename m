Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbSIXPam>; Tue, 24 Sep 2002 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbSIXPam>; Tue, 24 Sep 2002 11:30:42 -0400
Received: from web40510.mail.yahoo.com ([66.218.78.127]:27965 "HELO
	web40510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261694AbSIXPam>; Tue, 24 Sep 2002 11:30:42 -0400
Message-ID: <20020924153549.84703.qmail@web40510.mail.yahoo.com>
Date: Tue, 24 Sep 2002 08:35:49 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: scsi error.
To: jbradford@dial.pipex.com, "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209231615.g8NGFNu1001833@darkstar.example.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved. I didn't enable term power on the last drive in my SCSI chain.
Errors gone now. Thanks.


-Alex

--- jbradford@dial.pipex.com wrote:
> > You apparently have a Data Parity Error on your SCSI bus.  Probably your
> > external SCSI drive has a cable or terminator problem.  You can confirm this
> > by disconnecting the external SCSI cable to see if the other drives come up
> > ok.  
> > You may be missing some termination, either via an external terminator or by
> > turning on the drive's TERMPWR jumper on the external drive (depending on
> > the type of disk cabinet you have).  Or, the external SCSI cable may be
> > faulty (usually bent pins).
> 
> Also, it could be that you are using a cable designed for a Mac - those cables often don't have
> all of the GND lines individually connected, and can cause seemingly random problems.
> 
> John

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
