Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTJUBDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTJUBDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:03:48 -0400
Received: from mra01.ex.eclipse.net.uk ([212.104.129.110]:2024 "EHLO
	mra01.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S263294AbTJUBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:03:47 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Date: Tue, 21 Oct 2003 02:03:44 +0100
User-Agent: KMail/1.5.4
References: <20031020132705.GA1171@synertronixx3> <20031020215401.GB15563%konsti@ludenkalle.de> <20031020230510.GD15563%konsti@ludenkalle.de>
In-Reply-To: <20031020230510.GD15563%konsti@ludenkalle.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310210203.45512.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Oct 2003 00:05, Konstantin Kletschke wrote:
> The new K7S5A Pro behaves strange.
>
> When lilo comes up, it gets keyboard input containing of 4-6 lines
> "t:t:t:t:t:t:t:t:t:t:t:t:"...
> When hitting backspace whole line gets cleared, enter boots default then.
> WTF?
> even with no keyboard plugged in. My first thought was disabling
> "usb-keyboard support for dos" but... only a usb printer, ethernet and
> serial modem are plugged in...

Kernel configuration optins aren't going to affect LILO unless it's some 
strange data being left over from before reboot.  Complete guess, but could 
it be some kind of BIOS test data that isn't getting cleared?

-- 
Ian.

