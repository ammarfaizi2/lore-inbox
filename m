Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVLMGId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVLMGId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVLMGId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:08:33 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:13408 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932466AbVLMGIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:08:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Mouse button swapping
Date: Tue, 13 Dec 2005 01:08:28 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512130108.29822.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 December 2005 09:10, Jan Engelhardt wrote:
> Hi,
> 
> 
> I produced a small patch that allows one to flip the mouse buttons at the 
> kernel level. This is useful for changing it on a per-system basis, i.e. it 
> will affect gpm, X and VMware all at once. It is changeable through
> /sys/module/mousedev/swap_buttons at runtime. Is this something mainline would
> be interested in?

I am not sure if this should be done in kernel. It will also not work for mouse
drivers using event interface (which hopefully will be default someday) instead
of legacy mousedev interface.

-- 
Dmitry
