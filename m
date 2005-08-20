Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbVHTAci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbVHTAci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbVHTAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:32:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44466 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932765AbVHTAch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:32:37 -0400
Subject: Re: Atheros and rt2x00 driver
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       rt2400-general@lists.sourceforge.net
In-Reply-To: <6278d22205081711115b404a9b@mail.gmail.com>
References: <6278d22205081711115b404a9b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 20:32:33 -0400
Message-Id: <1124497953.25424.112.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 19:11 +0100, Daniel J Blueman wrote:
> Ralink Tech (www.ralink.com.tw) took a design decision to incorporate
> the firmware into an EEPROM on-board, allowing their driver to be
> GPL'd 

Binary only firmware and firmware loading is perfectly compatible with
the GPL, as long as the vendor includes a license to redistribute the
firmware.  The problem was that vendors were distributing the firmware
embedded in the driver code as a big hex string, without a separate
license, which made the firmware fall under the GPL, which make the
whole kernel undistributable as there's no source code for the firmware.

Lee

