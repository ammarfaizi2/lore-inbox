Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUCOT4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUCOT4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:56:16 -0500
Received: from host199.200-117-131.telecom.net.ar ([200.117.131.199]:50575
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S262736AbUCOTzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:55:50 -0500
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: "Richard W. Knight" <rick_knight@rlknight.com>
Subject: Re: How to apply -mm patch?
Date: Mon, 15 Mar 2004 16:54:57 -0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <40560571.5070504@rlknight.com>
In-Reply-To: <40560571.5070504@rlknight.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403151654.57803.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard W. Knight wrote:
> Can someone give me
> a quick example of how to apply the 2.6.4-mm patch to linux-2.6.4?

Assuming your vanilla kernel is on /usr/src/linux, then:

	# cd /usr/src/linux
	# bzcat /path/to/mm-patch.bz2 | patch -p1

Regards,
Norberto
