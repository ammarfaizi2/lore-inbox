Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTAVHgT>; Wed, 22 Jan 2003 02:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTAVHgT>; Wed, 22 Jan 2003 02:36:19 -0500
Received: from smtp.mailix.net ([216.148.213.132]:2164 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267370AbTAVHgS>;
	Wed, 22 Jan 2003 02:36:18 -0500
Date: Wed, 22 Jan 2003 08:45:49 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SIOCGSTAMP does not work ?
Message-ID: <20030122074549.GA362@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <Pine.LNX.4.51.0301211636500.3454@dns.toxicfilms.tv> <20030121165515.GB5239@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.51.0301211759260.15348@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0301211759260.15348@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak, Tue, Jan 21, 2003 18:03:34 +0100:
> > > i was recently trying to use SIOCGSTAMP to get the date of the last packet
> > > that arrived on the socket. like so:
> >
> > which kernel?
> 2.4.20
> 
> If you can, please try to get the timestamp on any socket using.
> 
> struct timeval tv;
> ...
> ioctl (s, SIOCGSTAMP, &tv);
> 

sorry for delay.


I don't think SIOCGSTAMP was designed to work on "any socket".
It retrieves the timestamp correctly for PF_PACKET sockets though.
I may want to look at the libpcap source.

-alex
