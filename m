Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSKXUft>; Sun, 24 Nov 2002 15:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSKXUft>; Sun, 24 Nov 2002 15:35:49 -0500
Received: from lord.banki.hu ([193.225.225.14]:37488 "HELO lord.banki.hu")
	by vger.kernel.org with SMTP id <S261678AbSKXUft>;
	Sun, 24 Nov 2002 15:35:49 -0500
Date: Sun, 24 Nov 2002 21:42:59 +0100
From: Janos Farkas <chexum@shadow.banki.hu>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: SIS 630 poweroff on X shutdown
Message-ID: <priv$1038170202.lord@shadow.banki.hu>
Mail-Followup-To: Justin Pryzby <justinpryzby@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <E18FmZY-00008t-00@perseus.homeunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/0.96.2i
In-Reply-To: <E18FmZY-00008t-00@perseus.homeunix.net>; from Justin Pryzby on Sat, Nov 23, 2002 at 09:32:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-23 at 21:32:36, Justin Pryzby wrote:
> While running X 4.2.99.2, under Linux 2.4.20-rc3, the control-alt-backspace key
> sequence kills X; however, it also shuts down the computer.

I have a SIS based motherboard too, and it does it for me too, kind of.
Providing I do it via a PS/2 keyboard, via USB it does not happen.
Also, it does not shut down, just puts it in a power save mode.  You do
have APM enabled, right?

Apparently, this is a BIOS feature, but I have not managed to find out
what setting needs to be there to be able to poweroff via halt -p, but
not via this ctrl-alt-bs...  Maybe you want to play with it and report? :)

> I doubt this is entirely a kernel issue; I plan on contacting the X people
> as well.  However, it seems that there may be a kernel problem, as X really
> shouldn't take the system down.

I was surprised too, but does not seem to be even Linux specific
either..

-- 
Janos
romfs is at http://romfs.sourceforge.net/
