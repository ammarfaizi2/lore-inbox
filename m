Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272886AbTG3OUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272883AbTG3OUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:20:07 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:33809 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272913AbTG3OSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:18:18 -0400
Date: Wed, 30 Jul 2003 16:18:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pilaszy Istvan <pila@inf.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in loopback device (Linux version 2.6.0-test2)
Message-ID: <20030730141816.GB2507@win.tue.nl>
References: <Pine.GSO.4.00.10307301313200.21959-100000@kempelen.iit.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.00.10307301313200.21959-100000@kempelen.iit.bme.hu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 01:23:17PM +0200, Pilaszy Istvan wrote:

> I found a bug in the loopback device.

Not really.

If you setup a loop device on a file or other device,
then the block device involved is the loop device.
Any access to that same file or device not via the
loop device will give undesired results.

