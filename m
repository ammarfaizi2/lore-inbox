Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbUJ0PxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUJ0PxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUJ0PwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:52:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59540 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262463AbUJ0Pvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:51:51 -0400
Subject: Re: [2.6.10-rc1-bk5] e1000 broken badly on IBM T42
From: Lee Revell <rlrevell@joe-job.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <200410270521.56816.shawn.starr@rogers.com>
References: <200410270033.22804.shawn.starr@rogers.com>
	 <200410270054.30313.shawn.starr@rogers.com>
	 <200410270521.56816.shawn.starr@rogers.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 11:51:50 -0400
Message-Id: <1098892310.8313.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 05:21 -0400, Shawn Starr wrote:
> I should just answer it myself, restarting fixed the interface negotiation 
> 'blip'. Perhaps the driver somehow did not reset and retry negotiation?
> 
> That did look interesting though :)

AIUI it's impossible to do 100% reliable autonegotiation with Ethernet.
The best you can do is try to detect when you might have gotten it wrong
and reset the interface.

Lee

