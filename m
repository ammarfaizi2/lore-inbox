Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWFHXMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWFHXMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWFHXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:12:41 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:2211 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965044AbWFHXMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:12:40 -0400
Date: Thu, 8 Jun 2006 19:07:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <448893DD.7010207@microgate.com>

On Thu, 08 Jun 2006 16:17:17 -0500, Paul Fulghum wrote:

> > Very infrequently I get kernel freezes while pppd is exiting.
> > Today I finally got traces from the serial console.
> 
> Chuck:
> 
> What kind of device are you using with pppd?
> (so I can identify which driver is feeding
> the tty layer receive data)

Just a regular 16550A port at 57600 baud using the 8250 driver.

> Are you setting the low_latency flag on that device?
> (setserial)

Not that I know of.

-- 
Chuck

