Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRE2X22>; Tue, 29 May 2001 19:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRE2X2S>; Tue, 29 May 2001 19:28:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8350 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262432AbRE2X2I>;
	Tue, 29 May 2001 19:28:08 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15124.12421.609194.476097@pizda.ninka.net>
Date: Tue, 29 May 2001 16:28:05 -0700 (PDT)
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <200105292316.QAA00305@csl.Stanford.EDU>
In-Reply-To: <15124.10785.10143.242660@pizda.ninka.net>
	<200105292316.QAA00305@csl.Stanford.EDU>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dawson Engler writes:
 > Is there any way to automatically find these?  E.g., is any routine
 > with "asmlinkage" callable from user space?

This is only universally done in generic and x86 specific code,
other ports tend to forget asmlinkage simply because most ports
don't need it.

Later,
David S. Miller
davem@redhat.com
