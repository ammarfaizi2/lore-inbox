Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSCRQYS>; Mon, 18 Mar 2002 11:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSCRQYI>; Mon, 18 Mar 2002 11:24:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34542
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S288019AbSCRQXz>; Mon, 18 Mar 2002 11:23:55 -0500
Date: Mon, 18 Mar 2002 08:24:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        =?unknown-8bit?Q?ChristianBorntr=E4ger?= 
	<christian@borntraeger.net>,
        linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: some ide-scsi commands starve drives on the same cable
Message-ID: <20020318162443.GH2254@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?unknown-8bit?Q?ChristianBorntr=E4ger?= <christian@borntraeger.net>,
	linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <E16mIEq-0006nO-00@the-village.bc.nu> <3C95E7E3.4020300@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 02:13:07PM +0100, Martin Dalecki wrote:
> Alan Cox wrote:
> >>during some activities (e.g. erasing a CDRW or fixating a CDR on my 
> >>CD-Burner) the hard disc on the same cable cannot be accessed.All data 
> >>and swap partitions are inaccessable. There is no dmesg output, just 
> >>entering the
> >>mount point fails.
> >>I am not sure if it is a kernel problem or if it is a firmware-bug.
> >
> >
> >Neither. Its an IDE design limitation. IDE can't handle disconnects like
> >real scsi does. The fixate command effectively locks the bus until it
> >completes. 
> >
> >There has been some movement forward in the standards on this. You might
> >want to ask our new 2.5 IDE maintainer if/when it will be implemented - I
> >suspect you have to wait a while though. There is much IDE to clean up 
> >first
> 
> Just for the record: I'm aware of it.
> 

That doesn't say much about your plans for it though.
