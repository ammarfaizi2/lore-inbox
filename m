Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131786AbRA2Krs>; Mon, 29 Jan 2001 05:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133006AbRA2Kri>; Mon, 29 Jan 2001 05:47:38 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:44302 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S131786AbRA2KrZ>;
	Mon, 29 Jan 2001 05:47:25 -0500
Date: Mon, 29 Jan 2001 11:47:52 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: Serial console != baud 9k6
Message-ID: <20010129114752.B2062@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i am just working on a different arch (mips board) and try to initialize
the serial console from the arch specific setup with
setup_console("ttyS0,57600") which doesnt work it seems as
serial_console_setup is itself "__init" and has a default of 9k6.

So how do i init the serial console from the arch specific stuff with
something else than the default baud rate ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
