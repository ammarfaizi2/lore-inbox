Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUAGXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUAGXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:54:16 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.117]:50642 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264374AbUAGXyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:54:14 -0500
Date: Wed, 7 Jan 2004 15:42:39 -0800
From: David Blackman <david@whizziwig.com>
To: linux-kernel@vger.kernel.org
Subject: SYM53C8XX (1010) not working in 2.6.0?
Message-ID: <20040107234239.GA25196@mort>
Reply-To: david@whizziwig.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all-

	I've been trying to get 2.6.0 to work on my desktop and I'm
having no luck with it. 

	This computer has a "LSI Logic / Symbios Logic 53c1010 Ultra3
SCSI Adapter" onboard, that works fine in 2.4.x with the SYM53C8XX
driver. I've compiled 2.6.0 with CONFIG_SCSI_SYM53C8XX_2=y, but it
doens't seem to work. When I boot, I don't see any scsi
initialization, and my root drive isn't connected, and I get a vfs
kernel panic that root can't be mounted.

	I'm almost positive no scsi stuff is being done in the kenrel,
because in 2.4 I could see it pause while it did all the script
loading stuff, but in 2.6 I see nothing like that, although I never
get keybaord control to be able to scroll back and see what messages
the kernel is printing.

	So, two questions -- why does the 2.6 driver work with my
53c1010 card, and why don't I have keyboard control on boot?

thanks,
--dave
