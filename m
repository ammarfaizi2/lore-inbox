Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288890AbSAERRd>; Sat, 5 Jan 2002 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288887AbSAERRX>; Sat, 5 Jan 2002 12:17:23 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:51209 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S288881AbSAERRG>;
	Sat, 5 Jan 2002 12:17:06 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201051716.g05HGeI125715@saturn.cs.uml.edu>
Subject: Re: ISA slot detection on PCI systems?
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 5 Jan 2002 12:16:40 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a168fs$p9q$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 04, 2002 11:03:24 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> Red herring.  It's not very nice for *applications* to not indirect
> through a driver, but if that driver is in userspace or kernel space
> is irrelevant.  Incidentally, "applications" here include a lot of the
> parsers that produce /proc output.  /proc/pci is occationally handy,
> but it is also an example on why you shouldn't do data reduction in
> kernel space unless you can avoid it.  Now /proc/bus/pci is available
> and contains all the data, however.

Of course, /proc/bus/pci contains forbidden binary files.
You're supposed to be happy with ASCII text, as found in
the /proc/pci file.

