Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTGOVmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbTGOVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:42:40 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24837 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269747AbTGOVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:42:38 -0400
Subject: Re: v2.6.0-test1 - no keyboard/mouse
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: folkert@vanheusden.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307152246.57389.folkert@vanheusden.com>
References: <200307152246.57389.folkert@vanheusden.com>
Content-Type: text/plain
Message-Id: <1058306246.584.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 23:57:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 22:46, Folkert van Heusden wrote:
> Ehrm, hello? Has this list became silent suddenly?
> Anyway: I just tried 2.6.0-test1 on my celeron. Boots up flawlessly. Rather 
> quick and all. X boots up, all fine.
> Only one minor problem: the keyboard and the mouse do not work.
> I *have* included input-core, etc.:
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=y

I can't think of anything except CONFIG_VGA_CONSOLE. Is it set to "y"?

