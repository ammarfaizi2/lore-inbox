Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTEMBrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTEMBrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:47:35 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:148 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263129AbTEMBrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:47:35 -0400
Date: Mon, 12 May 2003 21:57:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6 must-fix list, v2
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305122200_MC3-1-3890-B109@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - Alan: PCI random reordering from 2.4 to 2.5 isnt understood yet (might be
>   fixed now?)

  This is fixed for ide and anything else that relies on PCI bus order.
Network cards rely on link order and nobody has volunteered to fix it
(the latest proposal I saw is not even 2.4-compatible.)


