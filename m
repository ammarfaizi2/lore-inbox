Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTAXGCp>; Fri, 24 Jan 2003 01:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTAXGCp>; Fri, 24 Jan 2003 01:02:45 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:59310
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267553AbTAXGCi>; Fri, 24 Jan 2003 01:02:38 -0500
Subject: Re: AW: AW: 2.4.20 CPU lockup - Now with OOPS message
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: dk@webcluster.at
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <DIEGIJEABDDLMLKJFCKJMEFMCEAA.dk@webcluster.at>
References: <DIEGIJEABDDLMLKJFCKJMEFMCEAA.dk@webcluster.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043388611.12855.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 00:10:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 20:33, Daniel Khan wrote:
> Hi,
> 
> [..]
> > I was able to successfully reproduce this error in a test setup, but not
> > the crashes. I'm curious if maybe I just start up too many instances of
> > rsync and see what happens.
> >
> > Any particular method or size of files, etc, in reproducing this would
> > be greatly beneficial. TIA
> 
> Here is the command
> /usr/local/bin/nice-rsync --rsync-path=/usr/local/bin/nice-rsync --whole-fil
> e -auq --delete /var/log/httpd/ 10.1.0.212:/var/log/httpd
> 
> /usr/local/bin/nice-rsync :
> 
> #!/bin/sh
>   exec nice -n 19 rsync $*
> 
> Best regards
> 
> Daniel Khan


Kewl. Thanks, I will try this out tomorrow and let you know.
