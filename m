Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUBBON3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUBBON3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:13:29 -0500
Received: from charybdis.rus.uni-stuttgart.de ([129.69.1.58]:22595 "EHLO
	charybdis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S265501AbUBBON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:13:28 -0500
Date: Mon, 2 Feb 2004 15:13:25 +0100
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1rc1] usb memorystick doesnt work / 2.6.0-test9 does work
Message-ID: <20040202141325.GA9422@deneb.enyo.de>
References: <20040106180704.GA9132@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106180704.GA9132@paradigm.rfc822.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Lohoff wrote:

> i found by accident that my memorystick does work anymore with 2.6.1rc1.
> Last kernel i tried it works with is -test9. -test11, 2.6.0 seem all not
> work.

We got bitten by this bug, too (but it worked with 2.6.0 for us).
2.6.2rc2 doesn't work either:

Feb  2 15:08:49 blackhawk kernel: Current sda: sense key No Sense               
Feb  2 15:08:49 blackhawk kernel: end_request: I/O error, dev sda, sector 32    
