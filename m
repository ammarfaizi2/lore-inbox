Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTJORkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJORks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:40:48 -0400
Received: from hugin.maersk-moller.net ([193.88.237.237]:20357 "EHLO
	hugin.maersk-moller.net") by vger.kernel.org with ESMTP
	id S263777AbTJORkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:40:40 -0400
Message-ID: <3F8D8690.9040104@maersk-moller.net>
Date: Wed, 15 Oct 2003 19:40:32 +0200
From: Peter Maersk-Moller <peter@maersk-moller.net>
Organization: Visit <http://www.maersk-moller.net/>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
References: <3F8D1377.3060509@maersk-moller.net> <3F8D3A47.1000804@maersk-moller.net> <Pine.LNX.4.53.0310151124180.2328@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310151124180.2328@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Zwane Mwaikambo wrote:
>>More info on the subject. It turns out that a 2.4.22 kernel
>>without SMP-support but with IO-APIC enabled will also lock-up/stop
>>when it installs the aic7xxx driver upon boot. Disabling the IO-APIC
>>and disabling SMP-support makes the kernel boot normally.

> How about UP and IO-APIC?

Assuming UP means uni-processor, do you then mean removing
one of the processors or just disabling (ie. not enabling) SMP ?

The latter case (enabling IO-APIC and disabling SMP) makes the
boot process halt when it come to activating the aic7xxx driver.

--PMM

----------------------------------------------------------------
Peter Maersk-Moller
----------------------------------------------------------------
Ogg/Vorbis support for MPEG4IP. YUV12, XviD, AVI and MP4 support
for libmpeg2. See http://www.maersk-moller.net/projects/
----------------------------------------------------------------

