Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSGWHMc>; Tue, 23 Jul 2002 03:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSGWHMc>; Tue, 23 Jul 2002 03:12:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24074 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317977AbSGWHMb>; Tue, 23 Jul 2002 03:12:31 -0400
Date: Tue, 23 Jul 2002 08:15:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] uart_start thinko
Message-ID: <20020723081538.A13337@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207230818410.32636-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207230818410.32636-100000@linux-box.realnet.co.sz>; from zwane@linuxpower.ca on Tue, Jul 23, 2002 at 08:20:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 08:20:00AM +0200, Zwane Mwaikambo wrote:
> Hi Russell,
> 	With this patch i can now fully use the console as i normally do, 
> ie kernel messages, agetty and syslogd. I think you forgot to remove the 
> other locks when you were doing the shuffle between __uart_start and
> uart_start ;)

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

