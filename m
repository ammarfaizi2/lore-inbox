Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGUVIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGUVIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGUVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:08:21 -0400
Received: from mail1.cenara.com ([193.111.152.3]:26581 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S1751175AbWGUVIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:08:20 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: input: Oops when unplugging opened Wacom USB device
Date: Fri, 21 Jul 2006 23:08:16 +0200
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <200607212029.23617.wigge@bigfoot.com> <d120d5000607211153p541a56bbo2f121dd9aa41743d@mail.gmail.com>
In-Reply-To: <d120d5000607211153p541a56bbo2f121dd9aa41743d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607212308.16639.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 July 2006 20:53, Dmitry Torokhov wrote:
> On 7/21/06, Magnus Vigerlöf <wigge@bigfoot.com> wrote:
> > Does somebody knows the reason for the lack of locking in this part
> > of the code? The code is similar and the problems may be the same
> > in joydev.c and tsdev.c as well.
>
> Ahem, well, just lack of time I suppose. I am starting adding some
> locking to the input core, once its done we can work on locking in
> handlers.

Ah, good to know it's on the TODO-list. I do have a way around this 
race-condition so I'm not severly affected by it.

 Magnus
