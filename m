Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTENBzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTENBzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:55:02 -0400
Received: from CPE-24-163-212-250.mn.rr.com ([24.163.212.250]:27779 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S262182AbTENBzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:55:00 -0400
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@digeo.com>
Cc: wli@holomorphy.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513190647.0c6459af.akpm@digeo.com>
References: <1052866461.23191.4.camel@www.enodev.com>
	 <20030514012731.GF8978@holomorphy.com>
	 <1052877161.3569.17.camel@www.enodev.com>
	 <20030513190647.0c6459af.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1052877939.3569.23.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 21:05:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DUDE! Thanks mucho!

> rpm seems generally flakey sometimes.
> 
> remove /var/lib/rpm/__*
> 
> Use
> 
> 	LD_ASSUME_KERNEL=2.2.5 rpm
> 
> to get around rpm's O_DIRECT bug.
> 
