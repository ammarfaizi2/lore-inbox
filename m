Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJYOZ2>; Thu, 25 Oct 2001 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274513AbRJYOZS>; Thu, 25 Oct 2001 10:25:18 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:1545 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S274434AbRJYOZC>;
	Thu, 25 Oct 2001 10:25:02 -0400
Date: Thu, 25 Oct 2001 08:20:01 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Rob Turk <r.turk@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011025082001.B764@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:27:11AM +0200, Rob Turk wrote:
> > The act of "suspend" should basically be: shut off the SCSI controller,
> > screw all devices, reset the bus on resume.
> >
> 
> Doing so will create havoc on sequential devices, such as tape drives. If

I'm failing  to imagine a good case for suspending a system that has a
tape drive on it.




