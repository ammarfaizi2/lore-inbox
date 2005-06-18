Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVFRPF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVFRPF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVFRPEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:04:12 -0400
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:35254 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262135AbVFRPBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:01:15 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 15:58:56 +0100
User-Agent: KMail/1.8.1
References: <200506181332.25287.nick@linicks.net> <200506181403.41212.s0348365@sms.ed.ac.uk> <200506181444.52670.nick@linicks.net>
In-Reply-To: <200506181444.52670.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181558.56533.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 14:44, Nick Warne wrote:
> >
> > I had this problem because I was running an ancient version of udev
> > (0.34, versus 0.58, at the time..). Try upgrading udev if it's out of
> > date.
>
> Thanks, that worked :-)
>

FWIW In the udev 058 announcement, Greg said:

"Note, if you are running a kernel newer than 2.6.12-rc4 (including the
-mm releases) and you have any custom udev rules, you MUST upgrade to
the latest version to allow udev to work properly.  This change happened
because of a previously-unrealized reliance in libsysfs on the presence
of a useless sysfs file that has recently been removed.  Hopefully the
libsysfs people will be releasing a new version shortly with this change
in it for those packages who rely on it."

Just a reminder because I bet many people will get caught out by this!

Andrew Walrond
