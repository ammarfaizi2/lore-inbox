Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271546AbTGQSJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271582AbTGQSJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:09:10 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:35722 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id S271546AbTGQSIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:08:46 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6.0-test1 - no keyboard/mouse
Date: Thu, 17 Jul 2003 20:23:51 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.43.0307151702570.1640-100000@morpheus>
In-Reply-To: <Pine.LNX.4.43.0307151702570.1640-100000@morpheus>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307172023.51652.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never mind, got it solved. It seems you have to check quiet a few things to 
get basic things like keyboards to work and such. Maybe the 
configuration-thing should emit a warning when basic things like 
keyboard/console-on-whatever are omitted. Just a warning.

On Tuesday 15 July 2003 23:03, you wrote:
> dmesg?
>
>
> On Tue, 15 Jul 2003, Folkert van Heusden wrote:
> > Ehrm, hello? Has this list became silent suddenly?
> > Anyway: I just tried 2.6.0-test1 on my celeron. Boots up flawlessly.
> > Rather quick and all. X boots up, all fine.
> > Only one minor problem: the keyboard and the mouse do not work.
> > I *have* included input-core, etc.:
> > CONFIG_INPUT=y
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_EVDEV=y
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_INPUT_MISC=y
> > CONFIG_INPUT_PCSPKR=y
> > CONFIG_INPUT_UINPUT=y
> > Anyone got a suggestion?
> > You'll find the complete .config at vanheusden.com/config260 (not
> > attached to reduce unneccessary traffic).
> >
> >
> > Folkert van Heusden
> >
> > p.s. please CC me: I'm not sure if I'm still on this list or not
> >
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 


Folkert van Heusden

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

