Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTEZF3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTEZF3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:29:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264270AbTEZF33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:29:29 -0400
Date: Sun, 25 May 2003 22:42:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED1A7DB.1000507@pobox.com>
Message-ID: <Pine.LNX.4.44.0305252240490.10183-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:
> 
> I think with SATA + drivers/ide, you reach a point of diminishing 
> returns versus amount of time spent on mid-layer coding.

I think that's a valid approach, and just have a special driver for SATA. 
That's not the part I worry about. 

The part I worry about is the SCSI layer itself, and also potential user
confusion.

		Linus

