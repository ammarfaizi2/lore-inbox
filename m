Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWJROFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWJROFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWJROFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:05:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:56774 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751069AbWJROFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:05:09 -0400
From: Duncan Sands <duncan.sands@free.fr>
To: Simon Morgan <zen84964@zen.co.uk>
Subject: Re: SpeedTouch Disconnections
Date: Wed, 18 Oct 2006 16:05:02 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061018121815.GA6933@bollo>
In-Reply-To: <20061018121815.GA6933@bollo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181605.02854.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

> I'm currently using a SpeedTouch 330 USB ADSL modem along with the
> speedtch kernel module and pppd with the pppoatm.so plugin.
> 
> The problem is that the connection keeps dying and the only way to get
> it working again is to kill pppd and unplug the modem and plug it back
> in. This is what gets sent to syslog:
> 
> pppd[4393]: No response to 10 echo-requests
> pppd[4393]: Serial link appears to be disconnected.
> pppd[4393]: Connect time 582.1 minutes.
> pppd[4393]: Sent 1825559 bytes, received 22851915 bytes.
> pppd[4393]: Script /etc/ppp/ip-down started (pid 6755)
> pppd[4393]: sent [LCP TermReq id=0x2 "Peer not responding"]
> pppd[4393]: Script /etc/ppp/ip-down finished (pid 6755), status = 0x0
> pppd[4393]: sent [LCP TermReq id=0x3 "Peer not responding"]
> pppd[4393]: Connection terminated.
> pppd[4393]: Modem hangup
> 
> I used to use a Cisco SOHO 97 (a very nice piece of kit) which never
> dropped the connection unless there was some kind of external problem.
> Well, either that or I just never noticed when it reconnected. In fact I
> used to get this exact same problem years ago when I used this modem.
> Either way I don't think this is a problem with anything beyond the
> driver and/or pppd. The question is which and how do I go about finding
> the source of the problem?
> 
> Any kind of help or pointers would be much appreciated.

if you are using kernel 2.6.17, try upgrading to the latest 2.6.17 stable
release.  If you have an Intel UHCI, upgrade to 2.6.18.  Otherwise, please
send details of what kernel you are running, what distribution, what firmware
you are using etc.

Best wishes,

Duncan.
