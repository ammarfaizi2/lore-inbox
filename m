Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUHQNBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUHQNBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUHQNBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:01:20 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:8890 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268216AbUHQNBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:01:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch is this? - Unsure still
Date: Tue, 17 Aug 2004 08:01:00 -0500
User-Agent: KMail/1.6.2
Cc: Shawn Starr <shawn.starr@rogers.com>
References: <200408170349.44626.shawn.starr@rogers.com> <200408170402.33368.shawn.starr@rogers.com>
In-Reply-To: <200408170402.33368.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408170801.00068.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 03:02 am, Shawn Starr wrote:
> Sorry, I stand corrected. I don't know where this patch is added from which 
> enables the touchpad to act as a 'button press'.
>

mousedev now does tap emulation for touchpads working in absolute mode
(Synaptics) so you don't need to use psmouse.proto= parameter to force
it in PS/2 compatibility mode. Use mousedev.tap_time= option to control
it.

The patch is only in -mm at the moment.

-- 
Dmitry
