Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbQLLSaT>; Tue, 12 Dec 2000 13:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131059AbQLLSaK>; Tue, 12 Dec 2000 13:30:10 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:29173 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130895AbQLLS3z>; Tue, 12 Dec 2000 13:29:55 -0500
Date: Tue, 12 Dec 2000 18:13:39 +0100
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
Message-ID: <20001212181339.F2602@storm.local>
Mail-Followup-To: "Mohammad A. Haque" <mhaque@haque.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A3623C6.B2499D4D@haque.net> <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net>; from mhaque@haque.net on Tue, Dec 12, 2000 at 09:34:30AM -0500
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 09:34:30AM -0500, Mohammad A. Haque wrote:
> Someone gave me a really awesome idea about possibly using a palm pilot
> to capture the oops. Anyone know if it will be a problem using
> /dev/ttyUSB0 as the serial port?

The driver itself has to provide support for serial console.  If the USB
serial driver doesn't (I don't know) it won't work.  Check the config
options for USB serial, if it doesn't offer an option for console on USB
serial port then you're out of luck.

Unless the USB serial driver in some strange way hooks into the standard
serial driver, but then someone more knowledgeable should answer that
question.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
