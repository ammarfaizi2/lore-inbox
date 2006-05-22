Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWEVRsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWEVRsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEVRsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:48:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751064AbWEVRsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:48:53 -0400
Date: Mon, 22 May 2006 13:48:18 -0400
From: Dave Jones <davej@redhat.com>
To: Laurence Vanek <lvanek@charter.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: Kernel 2.6.16-1.2122_FC5 & lmsensors
Message-ID: <20060522174818.GA8016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Laurence Vanek <lvanek@charter.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
	Chris Wright <chrisw@sous-sol.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Jean Delvare <khali@linux-fr.org>
References: <4471F028.4090803@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471F028.4090803@charter.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 12:08:56PM -0500, Laurence Vanek wrote:
 > Upon updating to the latest kernel (2.6.16-1.2122_FC5) & rebooting I 
 > find that I no longer have lmsensors.  /var/log/messages gives this in 
 > the suspect area:
 > 
 > ==========
 > May 22 11:42:42 localhost kernel: i2c_adapter i2c-0: SMBus Quick command 
 > not supported, can't probe for chips
 > May 22 11:42:42 localhost kernel: i2c_adapter i2c-1: SMBus Quick command 
 > not supported, can't probe for chips
 > May 22 11:42:42 localhost kernel: i2c_adapter i2c-2: SMBus Quick command 
 > not supported, can't probe for chips
 > =========
 > 
 > something new in this release?

Probably a side-effect of [PATCH] smbus unhiding kills thermal management
merged in 2.6.16.17.  Is this an ASUS board ?

		Dave

-- 
http://www.codemonkey.org.uk
