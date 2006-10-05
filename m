Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWJEKjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWJEKjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWJEKjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:39:55 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:27964 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751599AbWJEKjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:39:54 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: jt@hpl.hp.com
cc: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing 
In-reply-to: Your message of "Mon, 02 Oct 2006 14:58:12 MST."
             <20061002215812.GA15476@bougret.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Oct 2006 20:39:30 +1000
Message-ID: <10086.1160044770@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes (on Mon, 2 Oct 2006 14:58:12 -0700) wrote:
>On Mon, Oct 02, 2006 at 05:26:04PM -0400, Theodore Tso wrote:
>> On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
>> > Distributions _are_ shipping those tools already.  The problem is more
>> > with older distributions where, for example, the kernel gets upgraded
>> > but other stuff does not.  If a kernel upgrade happens, then the distro
>> > needs to make sure userspace works with it.  That's nothing new.
>> 
>> Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
>> thought we saw a note saying that even Debian **unstable** didn't have
>> a new enough version of the wireless-tools....
>
>	I personally never said it was shipping already in all distro.
>...
>	SuSE I can't figure out.

SLES9 SP3:
  wireless-tools-27pre12-39.31 (WE_VERSION 16)
  No wpa_supplicant

SLES10:
  wireless-tools-28pre13-22.4 (WE_VERSION 19)
  wpa_supplicant-0.4.8-14.8

SuSELinux 10.1:
  wireless-tools-28pre13-20 (WE_VERSION 19)
  wpa_supplicant-0.4.8-14

openSUSE-10.2-Alpha4:
  wireless-tools-29pre10-3 (WE_VERSION 21)
  wpa_supplicant-gui-0.4.8-17

Only openSUSE 10.2 (which is still in Alpha status) has WE_VERSION 21
support.

