Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286300AbRLTRWc>; Thu, 20 Dec 2001 12:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286299AbRLTRWX>; Thu, 20 Dec 2001 12:22:23 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:7042 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S286296AbRLTRWS>;
	Thu, 20 Dec 2001 12:22:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: spike@superweb.ca, linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Thu, 20 Dec 2001 09:22:15 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <01122013105001.27161@spikes>
In-Reply-To: <01122013105001.27161@spikes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16H6tc-0000jz-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 20, 2001 09:10, Brendan Pike wrote:
> [root@spikes spike]# /sbin/hdparm -T /dev/hda
> /dev/hda:
> Timing buffer-cache reads:   128 MB in  3.89 seconds = 32.90 MB/sec

phalynx:/home/bodnar42# hdparm -T /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.63 seconds =203.17 MB/sec

Either you have an old computer with absolutely horrible memory bandwidth, or 
something is really wrong here.

-Ryan
