Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUHYCW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUHYCW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268531AbUHYCW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:22:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25790 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266376AbUHYCWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:22:22 -0400
Subject: Re: NForce 2 support
From: Lee Revell <rlrevell@joe-job.com>
To: Dr NoName <spamacct11@yahoo.com>
Cc: chakkerz_dev@optusnet.com.au, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040825020538.55821.qmail@web12306.mail.yahoo.com>
References: <20040825020538.55821.qmail@web12306.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093400541.5678.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 22:22:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 22:05, Dr NoName wrote:
> > nforce 2 works sweet with the exception of sound
> > which has been broken in 2.6.7 and 
> > 2.6.8.1 causing system crashes. If you have a
> > soundcard not to worry, if you are 
> > gonna run onboard ... wait and see with 2.6.9 brings
> 
> 
> is that with the open source drivers or nvidia
> proprietary ones? How do the two sets of drivers
> compare?
> 

The open source sound drivers do not work as well as the binary ones. 
SPDIF/AC3 does not work in the current ALSA driver and nvidia will not
release the required documentation to get it working.  Worse, the
binary-only driver is an OSS and not an ALSA driver!  Unbelievable.

The network driver had to be reverse engineered.  Apparently nvidia
engineers helped to get the gigabit support and some other features
working, but only after people had to reverse engineer the basic
functions.

Stick with VIA.  Nvidia is not Linux friendly.

Lee

