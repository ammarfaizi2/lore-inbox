Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263554AbRFFQbs>; Wed, 6 Jun 2001 12:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263560AbRFFQbi>; Wed, 6 Jun 2001 12:31:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41370 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263554AbRFFQbd>;
	Wed, 6 Jun 2001 12:31:33 -0400
Message-ID: <3B1E5AE0.9202DD00@mandrakesoft.com>
Date: Wed, 06 Jun 2001 12:31:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010606125556.A1766@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmmm.  I just looked over this, and drivers/char/joystick/ser*.[ch].

Bad trend.

Serial needs to be treated just like parport: the basic hardware code,
then on top of that, a selection of drivers, all peers:  dumb serial
port, serial mouse, joystick, etc.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
