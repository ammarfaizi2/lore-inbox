Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRFPOOs>; Sat, 16 Jun 2001 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbRFPOOj>; Sat, 16 Jun 2001 10:14:39 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:36105 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S264631AbRFPOOY>; Sat, 16 Jun 2001 10:14:24 -0400
Subject: Re: ps2 keyboard filter hook
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: ddstreet@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106151345510.25518-200000@ddstreet.raleigh.ibm.com>
In-Reply-To: <Pine.LNX.4.10.10106151345510.25518-200000@ddstreet.raleigh.ibm.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 16 Jun 2001 10:13:48 -0400
Message-Id: <992700829.9378.3.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2001 16:03:32 -0400, ddstreet@us.ibm.com wrote:
> 
> IBM Retail Store Solutions dept has certain PS/2 keyboards which extend the
> standard PS/2 specification in order to support addition hardware built into the
> keyboard (such as a Magnetic Strip Reader, Keylock, Tone generator, extra keys,
> -Dan

I'm facing a similar problem with the "Qoder" barcode scanner. I have to
have a keyboard hook. The "right" way seem to be to use the input api.
Unfortunately, this means that current kernels can't use the driver w/o
a patch (the input api patch). The ugly way is to patch the keyboard
driver. I'm doing both.

However, I wrote a REALLY SIMPLE hook tht supported exactly my needs,
since it's in the category of "ugly hack waiting for input api." Maybe
I'll write a version for your hook.

I wonder when the input api stuff for ps/2 devices will be a part of the
mainstream kernel...

--
Michael Rothwell
rothwell@holly-springs.nc.us


