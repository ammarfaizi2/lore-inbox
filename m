Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTDGOwY (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDGOvD (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:51:03 -0400
Received: from smtp03.web.de ([217.72.192.158]:44577 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263479AbTDGOu5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:50:57 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 17:02:08 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071702.08114.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have asked in many other mailing-lists, but I got no good
solution for my problem, so I try to ask here, although it may
not be the exaclty correct list for it.

I have developed my own device, that is connected to ttyS0.
To talk to my device, I need to set the state of the TxD line
manually to either 0 or 1 (+12v or -12v). What I try to say is,
I don't want to write a whole byte to the port, but only one single
bit, that then stays persistent on the line, until I reset its state.
Better sayed, I want to handle TxD line, like it's possible for
DTR-line for example.

Is kernel-support by the ttyS driver present for this, or do I
have to write my own driver for my device. I'm trying to
implement the driver in user-space, but I didn't find a solution
to set linestate of TxD.

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

