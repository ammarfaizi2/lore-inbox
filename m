Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWFLLXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWFLLXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWFLLXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:23:31 -0400
Received: from twin.jikos.cz ([213.151.79.26]:51391 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751880AbWFLLXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:23:11 -0400
Date: Mon, 12 Jun 2006 13:23:09 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Incorrect speed at Palm 100 serial adapter
Message-ID: <20060612112309.GA14262@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

If I set 57600 speed on Palm 100 USB/serial adapter (USB IDs 0x830, 0x80),
the speed is according to oscilloscope at 19200, but the tcsetattr
doesn't fail and subsequent tcgetattr returns 115200.

If the hardware supports it, the speed should be set to 115200. If it
doesn't, tcgetattr should then indicate 19200.

Linux kernel is 2.6.16.19.

CL<
