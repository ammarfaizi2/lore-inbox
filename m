Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUDOUZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUDOUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:25:21 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:49932 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262849AbUDOUY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:24:57 -0400
Date: Thu, 15 Apr 2004 22:25:23 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: radeonfb broken
Message-ID: <20040415202523.GA17316@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the radeonfb on a Radeon 9600 Pro with a TFT display, and
radeonfb very recently started to give me a picture at all, so I am
quite happy about that.

However, running mplayer does not work at all on radeonfb.  mplayer
inquires about the color depth, I am using 32 bit color depth for this,
but radeonfb says it's DirectColor instead of TrueColor, so mplayer
tries to initialize the palette and fails.

Also, using fbset to set the mode to 1600x1200 fails.  The mode is
changed, but the text console resolution stays the same.  Worse, a
"setfont" changes back to 1024x768.

Also, I cannot view images on console with fbi or fbv.

Felix
