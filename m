Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbULPEln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbULPEln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbULPEln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:41:43 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:35020 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262546AbULPElm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:41:42 -0500
Message-ID: <41C11202.2040009@lammerts.org>
Date: Wed, 15 Dec 2004 23:41:38 -0500
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org, lineak-devel@lists.sourceforge.net
Subject: Re: Linux input event extending tool exist?
References: <200412101638.05125.aivils@unibanka.lv> <20041210142044.GB20511@ucw.cz>
In-Reply-To: <20041210142044.GB20511@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> You can use evtest (attached). It's often found in the joystick RPMs.
> It's also in the linuxconsole.sf.net CVS repository.  On recent kernels
> it'll show the scancodes as well as the generated keycodes.

Vojtech, are you aware that this doesn't work well with 32-bit apps on 
x86-64 kernels? The ioctls don't work (no compat definitions), and 
struct input_event is 24 bytes instead of 16.

Eric
