Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVLWTnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVLWTnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVLWTm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:42:59 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:14781 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161018AbVLWTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:42:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [PATCH/RFT] tlclk: convert to the new platform device interface
Date: Fri, 23 Dec 2005 14:42:55 -0500
User-Agent: KMail/1.8.3
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>, torvalds@osdl.org
References: <F760B14C9561B941B89469F59BA3A8470C36C8F9@orsmsx401.amr.corp.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470C36C8F9@orsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512231442.56682.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 14:14, Gross, Mark wrote:
> The patch "looks" ok, but I have two issues:
> 
> 2.6.15-rc6, hangs on the udev startup on my RHEL4 system so I can't
> smoke test this and more importantly an errata update patch I sent out
> earlier didn't make it in.  (I was having email client issues with kmail
> changing tabs to spaces on me that day so it may be my fault that patch
> got dropped.)
> 
> How would you like to proceed?
> 1) Should I send out an update patch that includes yours and the errata
> patch, knowing that we can only say that it compiles.
> 2) Should I send a unit tested errata patch to a 2.6.14.latest version?
> 3) Both 1 and 2?
> 4) Just ack your patch (I did review it and it compiles and looks fine)
> and re-submit my errata changes on top of your update?
> 

My patch can safely wait till 2.6.16 opens so there is no hurry. I'd suggest
trying to resolve udev issue first and getting the errata patch into 2.6.15
and only then taking care of mine.

I do not know how critical that errata patch is to get it in 2.6.14.y. 

-- 
Dmitry
