Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUFXOVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUFXOVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUFXOVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:21:07 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:8112 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S264527AbUFXOVD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:21:03 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Norbert Preining <preining@logic.at>
Subject: Re: Time is running at high speed with 2.6-mm and HPET
Date: Thu, 24 Jun 2004 07:20:55 -0700
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <20040624132851.GC19068@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040624132851.GC19068@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406240720.59296.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert,

This is a known issue, try to upgrade to 2.6.7-mm2 if you can.

Matt H.

On Thursday 24 June 2004 6:28 am, Norbert Preining wrote:
> Hi!
>
> With 2.6-mm and
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> my clock is running about double the speed it should. This happens with
> a laptop (acer tm 654) and my good old athlon 1400 via pc.
>
> Turning off CONFIG_HPET_TIMER fixes the problem.
>
> I attach my config file for 2.6.7-mm1 and the dmesg output (first lines
> are missing)
>
> Best wishes
>
> Norbert
>
> ---------------------------------------------------------------------------
>---- Norbert Preining <preining AT logic DOT at>         Technische
> Universität Wien gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76 
> A9C0 D2BF 4AA3 09C5 B094
> ---------------------------------------------------------------------------
>---- Does it worry you that you don't talk any kind of sense?
>                  --- Douglas Adams, The Hitchhikers Guide to the Galaxy
