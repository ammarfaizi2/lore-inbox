Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUFKIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUFKIGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUFKIEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:04:12 -0400
Received: from alsvidh.mathematik.uni-muenchen.de ([129.187.111.42]:31433 "EHLO
	alsvidh.mathematik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S262080AbUFKHaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:30:07 -0400
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: 253114@bugs.debian.org
Subject: [2.6.6] evdev driver fails to recognise all keys on Apple iMac
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 11 Jun 2004 09:30:04 +0200
Message-ID: <hh8yeur1qb.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've come upon a strange problem using a stock first generation iMac
from Apple.  The system is running a 2.6.6 kernel, and loads most of
the modules via hotplug.  Unfortunately, some keys do not work, and
the log shows the following two entries:

 drivers/usb/input/hid-input.c: event field not found
 drivers/usb/input/hid-input.c: event field not found

I played with this a little, and it turns out that the problem goes
away if I either boot with the keyboard detached and plug it in when
the system is up and running, or build evdev into the kernel instead
of as a module.  Both solutions are not acceptable, so I'd be grateful
for hints or fixes.  If there is any information I can provide, please
let me know.

Regards, Jens.

-- 
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!
