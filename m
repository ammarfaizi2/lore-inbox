Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031211AbWI0XFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031211AbWI0XFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031212AbWI0XFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:05:06 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:45961 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031211AbWI0XFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:05:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Lswdf9D57hlscOyUef9eHzlgq68OdWoKudko4Y8lmft6+8PDV5L81c/A/Tmc/aEJYDJDTzdk3qPF+jKmofpH4Xx0AyOSd2yVlit6+6gHHsWnINFjOyIy3iWMO11DtyoQj+qhuJjTwJR9cDYNkrAn5k17K9zuRbunLzp2kLRb0DY=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] usb still sucks battery in -rc7-mm1
Date: Wed, 27 Sep 2006 15:46:16 -0700
User-Agent: KMail/1.7.1
Cc: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060924090858.GA1852@elf.ucw.cz> <Pine.LNX.4.64.0609241457250.17306@rhama.deepcore.ngn>
In-Reply-To: <Pine.LNX.4.64.0609241457250.17306@rhama.deepcore.ngn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271546.16604.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 September 2006 5:18 am, Theodoros V. Kalamatianos wrote:

> I have encountered at least 3 hubs (2 usb2 & 1 usb1) that will consume a 
> lot of power (about 2-2.5W if the laptop power consumption readings are to 
> be trusted) and heat up a lot (to the point of being too hot to touch for 
> more than a few seconds) even when no devices are connected, at least on 
> Linux. I have not tested them on a Windows machine to see if this is the 
> case there. The USB2 ones used Cypress chips. I do not know what your h/w 
> config is, but perhaps this is a similar case ?

Probably not unrelated.  I have one of those Cypress-based hubs; it's nice
except for the heat/power, which precludes using them in bus-powered mode
with a laptop (or anything) ... I don't much like wall-warts!

It might be too much to expect that when that hub's upstream port is
suspended, its power usage goes to something reasonable.

  
