Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUATRs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUATRs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:48:56 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:57517 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S265615AbUATRsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:48:53 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core update for 2.6.1
References: <20040120011036.GA6162@kroah.com> <yw1xsmibovwp.fsf@ford.guide>
	<20040120171435.GE18566@kroah.com>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 20 Jan 2004 18:48:50 +0100
In-Reply-To: <20040120171435.GE18566@kroah.com> (Greg KH's message of "Tue,
 20: 14:36 -0800")
Message-ID: <yw1x8yk2o6il.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Tue, Jan 20, 2004 at 09:40:22AM +0100, Måns Rullgård wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> >   o ALSA: add sysfs class support for ALSA sound devices
>> 
>> This is still only completed for the intel8x0 driver, right?
>
> The "device" and "driver" symlink will only show up for that driver,
> yes.  But the class support will work for all alsa devices.  Now we can
> add 1 line patches for all of the alsa drivers to enable those
> symlinks...

I see.

BTW, I still don't get a snd/controlC0 in /udev.  All the other ALSA
devices are there.

-- 
Måns Rullgård
mru@kth.se
