Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUL3EiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUL3EiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUL3EiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:38:13 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:18300 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261490AbUL3EiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:38:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Andrew Haninger <ahaning@gmail.com>
Subject: Re: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Date: Wed, 29 Dec 2004 23:38:08 -0500
User-Agent: KMail/1.6.2
References: <105c793f04122907116b571ebf@mail.gmail.com>
In-Reply-To: <105c793f04122907116b571ebf@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412292338.08931.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 December 2004 10:11 am, Andrew Haninger wrote:
> Hello.
> 
> I recently installed Linux 2.6.10 on my Gateway Solo 2500 notebook
> after using it happily with 2.4.27 (aside from some ACPI sleeping
> issues). Since installing the new kernel, I've noticed an odd problem
> with the Toshiba PS/2 touchpad which is used as a cursor. If I move my
> finger left and right along the 'bottom' portion of the touchpad or up
> and down along the right side, there is no movement from the mouse
> cursor at all. This behavior shows up using gdm and XFree86. Running
> 'xev' produces no output when these sides are used. However, if I move
> my finger left-right along the top side or up-down along the left
> side, the cursor moves just fine. Tapping the pad to click in the
> non-working areas and moving the finger from outside of these areas
> and then into them, however, works fine

What does dmesg and /proc/bus/input/devices say about your touchpad?

-- 
Dmitry
