Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130919AbRA2M6z>; Mon, 29 Jan 2001 07:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131425AbRA2M6p>; Mon, 29 Jan 2001 07:58:45 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:43787 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130919AbRA2M63>; Mon, 29 Jan 2001 07:58:29 -0500
Date: Mon, 29 Jan 2001 06:57:53 -0600
To: James Sutherland <jas88@cam.ac.uk>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010129065752.A10024@cadcamlab.org>
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sun, Jan 28, 2001 at 01:29:52PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[James Sutherland]
> That depends what you mean by "retry"; I wanted the ability to
> attempt a non-ECN connection. i.e. if I'm a mailserver, and try
> connecting to one of Hotmail's MX hosts with ECN, I'll get RST every
> time.  I would like to be able to retry with ECN disabled for that
> connection.

So write a script to disable ECN via sysctl, retry your outgoing MTA
queue, and re-enable ECN.  Run it via cron about once a day.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
