Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSGMKOf>; Sat, 13 Jul 2002 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSGMKOe>; Sat, 13 Jul 2002 06:14:34 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:23170 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S318144AbSGMKOe>; Sat, 13 Jul 2002 06:14:34 -0400
Date: Sat, 13 Jul 2002 13:20:57 +0300
From: Anssi Saari <as@sci.fi>
To: James Stevenson <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI + cdwriter problem
Message-ID: <20020713102057.GA11996@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	James Stevenson <mistral@stev.org>, linux-kernel@vger.kernel.org
References: <002d01c22882$f17436e0$0501a8c0@Stev.org> <E17ScQK-0000ih-00@the-village.bc.nu> <20020712185522.GA12751@sci.fi> <01fd01c22a4d$151c4da0$0501a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fd01c22a4d$151c4da0$0501a8c0@Stev.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 10:10:07AM +0100, James Stevenson wrote:
 
> the really bad thing is the fact that it never does reset
> for me a reboot is required for me to use the cd drive again.

Maybe you can try cdrdao unlock, I've found it seems to reset my drive
when it hangs. I wonder why it is that cdrecord -reset doesn't do anything
to ATAPI drives with ide-scsi.
