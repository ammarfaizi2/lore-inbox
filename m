Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284398AbRLMREO>; Thu, 13 Dec 2001 12:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284469AbRLMREF>; Thu, 13 Dec 2001 12:04:05 -0500
Received: from t2.redhat.com ([199.183.24.243]:22512 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284464AbRLMRDz>; Thu, 13 Dec 2001 12:03:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <BE390EC144E@vcnet.vc.cvut.cz> 
In-Reply-To: <BE390EC144E@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 17:03:12 +0000
Message-ID: <28227.1008262992@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VANDROVE@vc.cvut.cz said:
> As it requires userspace, complete realmode 16bit DOS environment, it
> should not live in kernel (due to being 16bit code, and requiring its
> own mm).

A mechanism for a userspace program to change the video mode, then tell 
vesafb about the new mode, might be the best way to do this.

--
dwmw2


