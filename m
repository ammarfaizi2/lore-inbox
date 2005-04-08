Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVDHTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVDHTHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVDHTHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:07:33 -0400
Received: from are.twiddle.net ([64.81.246.98]:19077 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262933AbVDHTHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:07:21 -0400
Date: Fri, 8 Apr 2005 12:07:09 -0700
From: Richard Henderson <rth@twiddle.net>
To: Rao Davide <davide.rao@atosorigin.com>
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Subject: Re: Linux Alpha port: kernel panik under moderate DISK IO conditions
Message-ID: <20050408190709.GB27845@twiddle.net>
Mail-Followup-To: Rao Davide <davide.rao@atosorigin.com>,
	linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
References: <42569BC7.5030709@atosorigin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42569BC7.5030709@atosorigin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 04:57:11PM +0200, Rao Davide wrote:
> My name is David Rao and I have an old alpha DS10 ds10 (ev6 
> Tsunami-webbrick cpu) with internal HDU on a LSI controller and external 
> HSZ80 storage attached to a Qlogic.

Well, the CONFIG_SCSI_QLOGIC_ISP driver isn't supported, and you
may have noticed prints big warning messages when you boot with it.

Fortunately, the CONFIG_SCSI_QLOGIC_1280 driver has been extended
to handle the 1020 and 1040 devices.  I've been using that for a
while now on my ds10.


r~
