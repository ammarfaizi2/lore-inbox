Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQLLW1P>; Tue, 12 Dec 2000 17:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLLW1G>; Tue, 12 Dec 2000 17:27:06 -0500
Received: from [216.161.55.93] ([216.161.55.93]:43515 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129588AbQLLW04>;
	Tue, 12 Dec 2000 17:26:56 -0500
Date: Tue, 12 Dec 2000 13:58:03 -0800
From: Greg KH <greg@wirex.com>
To: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
Message-ID: <20001212135803.A1148@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"Mohammad A. Haque" <mhaque@haque.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A3623C6.B2499D4D@haque.net> <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net> <20001212181339.F2602@storm.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001212181339.F2602@storm.local>; from andreas.bombe@munich.netsurf.de on Tue, Dec 12, 2000 at 06:13:39PM +0100
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 06:13:39PM +0100, Andreas Bombe wrote:
> On Tue, Dec 12, 2000 at 09:34:30AM -0500, Mohammad A. Haque wrote:
> > Someone gave me a really awesome idea about possibly using a palm pilot
> > to capture the oops. Anyone know if it will be a problem using
> > /dev/ttyUSB0 as the serial port?
> 
> The driver itself has to provide support for serial console.  If the USB
> serial driver doesn't (I don't know) it won't work.  Check the config
> options for USB serial, if it doesn't offer an option for console on USB
> serial port then you're out of luck.
> 
> Unless the USB serial driver in some strange way hooks into the standard
> serial driver, but then someone more knowledgeable should answer that
> question.

Nope, it doesn't specifically support the CONFIG_SERIAL_CONSOLE with all
of the register_console code, etc., so this will not work, sorry.

But it's something that I would gladly take a patch for :)

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
