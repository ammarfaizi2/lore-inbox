Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWFIV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWFIV6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWFIV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:58:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51918 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030552AbWFIV6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:58:46 -0400
Message-ID: <4489EF01.30001@zytor.com>
Date: Fri, 09 Jun 2006 14:58:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org> <4489EAFE.6090303@garzik.org> <e6cq1r$foi$1@terminus.zytor.com> <4489EEA7.8010704@garzik.org>
In-Reply-To: <4489EEA7.8010704@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Right, and that proves my point.  When you start making major changes 
> like 32->64 bit block numbers, you should communicate to the user (with 
> a big blinky "ext4" sign) that his filesystem metadata will change a 
> lot, not a little.  Not to mention that such code will add yet more "if 
> (new) .. else .." code.
> 

Forking the code and registering another filesystem name are two separate things, though. 
  You can easily have a single filesystem module register two different filesystem names.

	-hpa

