Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbTCTO5V>; Thu, 20 Mar 2003 09:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbTCTO5V>; Thu, 20 Mar 2003 09:57:21 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:9895 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261508AbTCTO5U>;
	Thu, 20 Mar 2003 09:57:20 -0500
Date: Thu, 20 Mar 2003 16:08:20 +0100
From: bert hubert <ahu@ds9a.nl>
To: "Filipau, Ihar" <ifilipau@sussdd.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: read() & close()
Message-ID: <20030320150820.GA25359@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Filipau, Ihar" <ifilipau@sussdd.de>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <7A5D4FEED80CD61192F2001083FC1CF9065139@CHARLY>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF9065139@CHARLY>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:14:52PM +0100, Filipau, Ihar wrote:

>     I have/had a simple issue with multi-threaded programs:
> 
>     one thread is doing blocking read(fd) or poll({fd}) on 
>     file/socket.

You can't do poll on a file, it won't tell you anything useful, so I assume
you mean a socket.

>     another thread is doing close(fd).
> 
>     I expected first thread will unblock with some kind 
>     of error - but nope! It is blocked!

Can you show code with this problem?

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
