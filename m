Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163187AbWLGSaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163187AbWLGSaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163188AbWLGSaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:30:35 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:56473 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163187AbWLGSac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:30:32 -0500
Date: Thu, 7 Dec 2006 19:27:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortel.com>
cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
In-Reply-To: <45783AE5.9090706@nortel.com>
Message-ID: <Pine.LNX.4.61.0612071927140.31022@yvahk01.tjqt.qr>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
 <Pine.LNX.4.61.0612071206160.2863@yvahk01.tjqt.qr> <45783AE5.9090706@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What keyword is "defined"? Did you have too much Perl coffee? :)
>
> Maybe macro formatting?
>
> #if defined(CONFIG_FOO)

Ah thanks for the hint. This also raises another stylistic aspect:

#ifdef XYZ over #if defined(XYZ) when there is only one macro to be 
tested for.


	-`J'
-- 
