Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUFRNCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUFRNCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUFRNCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:02:31 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:58483 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265135AbUFRNCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:02:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] New set of input patches
Date: Fri, 18 Jun 2004 08:02:28 -0500
User-Agent: KMail/1.6.2
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <200406180344.46191.dtor_core@ameritech.net> <20040618092121.GX20632@lug-owl.de>
In-Reply-To: <20040618092121.GX20632@lug-owl.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180802.28357.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 June 2004 04:21 am, Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 03:44:46 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
> wrote in message <200406180344.46191.dtor_core@ameritech.net>:
> 
> > would have parents. But the core integration is done. Unfortunately I do
> > not have 90% hardware to test my changes so there could be some problems,
> > although I tried to compile everything I could.
> 
> Maybe I'll test at least my two babies (vsxxxaa and lkkbd) to work with
> these patches. They're using normal serial ports (ISA + USB) with
> inputattach, these should already have parents, right?
> 

Right now nothing has a parent except for passthrough ports. I will do more
patches later, but when I as looking at the serial port code it seemed that
ther actual devices (as in struct device) were not available for ttys yet.

Please corect me if I am mistaken.

-- 
Dmitry
