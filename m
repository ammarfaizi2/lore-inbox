Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758846AbWK2NU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846AbWK2NU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbWK2NU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:20:59 -0500
Received: from mout2.freenet.de ([194.97.50.155]:65178 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1758846AbWK2NU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:20:58 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt8
Date: Wed, 29 Nov 2006 14:21:23 +0100
User-Agent: KMail/1.9.5
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20061127094927.GA7339@elte.hu> <200611290104.51731.fzu@wemgehoertderstaat.de> <20061129070649.GA32455@elte.hu>
In-Reply-To: <20061129070649.GA32455@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291421.24171.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. November 2006 08:06 schrieb Ingo Molnar:
> * Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> > After estimated 15 minutes more it bugged again.
> > Related dmesg translates to linux error
> > 	-EXDEV
> > propably caused by the following lines:
> >
> > <snip>
> > static int uhci_result_isochronous(struct uhci_hcd *uhci, struct
> > urb *urb)
>
> hm. Below are all the USB changes done by -rt. Maybe one of them has
> some side-effect?

On rc6-rt5 rt-audio with usb-sound runs just fine so far,
and I didn't find any USB changes between rc6-rt5 and rc6-rt8.

      Karsten
