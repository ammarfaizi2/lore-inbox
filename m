Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285089AbRLUUHn>; Fri, 21 Dec 2001 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLUUHd>; Fri, 21 Dec 2001 15:07:33 -0500
Received: from gherkin.frus.com ([192.158.254.49]:11394 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S285089AbRLUUHO>;
	Fri, 21 Dec 2001 15:07:14 -0500
Message-Id: <m16HVwW-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: sr: unaligned transfer
In-Reply-To: <20011221142133.C811@suse.de> "from Jens Axboe at Dec 21, 2001 02:21:33
 pm"
To: Jens Axboe <axboe@suse.de>
Date: Fri, 21 Dec 2001 14:06:56 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Dec 21 2001, Bob_Tracy wrote:
> > 	sr: unaligned transfer
> > 	Unable to identify CD-ROM format.
> 
> What fs?

iso9660.

> Please try and mount with -o loop instead.

???  Sorry if I'm being dense, but the file system is on a physical
CD: it isn't an image file.  The mount command that has worked for me
in the past is

	mount -t iso9660 /dev/sr1 /mnt -r

The sr1 device isn't a typo: it's my cd writer.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
