Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVAORms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVAORms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVAORmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 12:42:38 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:24947 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261292AbVAORmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 12:42:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marco Cipullo <cipullo@libero.it>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sat, 15 Jan 2005 12:42:30 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200501151205.29136.cipullo@libero.it>
In-Reply-To: <200501151205.29136.cipullo@libero.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501151242.31443.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 06:05 am, Marco Cipullo wrote:
> Same problem with me. I also have a laptop and I also have the same problem 
> started in the same period.
> 
...
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=m

Make i8042 compiled in or make sure that your init scripts load it. Right now
there are no traces of it in your boot log.

-- 
Dmitry
