Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUIQBtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUIQBtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268273AbUIQBtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:49:18 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:24202 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268271AbUIQBtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:49:17 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [INPUT] mousedev touchpad functionality additions for inclusion into 2.6.9?
Date: Thu, 16 Sep 2004 21:49:14 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200408170349.44626.shawn.starr@rogers.com> <200408170402.33368.shawn.starr@rogers.com> <200408170801.00068.dtor_core@ameritech.net>
In-Reply-To: <200408170801.00068.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409162149.14849.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any change of this going into mainline? I'm using this with 2.6.9-rc2-bk2 with 
no issues.

Shawn.

On August 17, 2004 09:01, Dmitry Torokhov wrote:
> On Tuesday 17 August 2004 03:02 am, Shawn Starr wrote:
> > Sorry, I stand corrected. I don't know where this patch is added from
> > which enables the touchpad to act as a 'button press'.
>
> mousedev now does tap emulation for touchpads working in absolute mode
> (Synaptics) so you don't need to use psmouse.proto= parameter to force
> it in PS/2 compatibility mode. Use mousedev.tap_time= option to control
> it.
>
> The patch is only in -mm at the moment.
