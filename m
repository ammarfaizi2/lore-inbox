Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbTFLG2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264747AbTFLG2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:28:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10705 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264746AbTFLG2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:28:46 -0400
Date: Thu, 12 Jun 2003 08:42:25 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: =?iso-8859-2?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>, ak@suse.de,
       vojtech@suse.cz, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030612084225.C12126@ucw.cz>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com> <3EE79FD1.8060503@kolumbus.fi> <1055366925.17154.95.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1055366925.17154.95.camel@serpentine.internal.keyresearch.com>; from bos@serpentine.com on Wed, Jun 11, 2003 at 02:28:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 02:28:45PM -0700, Bryan O'Sullivan wrote:

> On Wed, 2003-06-11 at 14:32, Mika Penttilä wrote:
> 
> > Line below seems to be wrong, given hpet period is in fsecs.
> 
> I don't believe the HPET code got much testing in 2.4, and my boxes
> don't have ACPI table entries for the HPET, so it's troublesome to test
> it on them.

You can enable HPET_HACK_ENABLE_DANGEROUS, of course. That will enable
the HPET even when the BIOS did not. But make sure you have a recent
AMD-8111 stepping first. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
