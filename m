Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTJGNlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTJGNlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:41:06 -0400
Received: from quechua.inka.de ([193.197.184.2]:18642 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262312AbTJGNlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:41:04 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: devfs vs. udev
Date: Tue, 07 Oct 2003 15:41:24 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.07.13.41.23.48967@dungeon.inka.de>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Oct 2003 12:39:27 +0000, Måns Rullgård wrote:
> I noticed this in the help text for devfs in 2.6.0-test6:
> 
> 	  Note that devfs has been obsoleted by udev,

devfs works fine, lists all devices, and obsoletes makedev.

udev needs patching for several issues, current sysfs only exports
many but by far not all devices, and because of that makedev
is still needed to create an initial /dev.

in short: devfs works fine. udev has quite a way to go.
so marking devfs obsolete was done too soon by far. but
greg wronte me he will spend some time on udev this week
if possible, so lets wait and see.

oops, that reminds me I should have send him a patch to
fix one issue. better late then never...

maybe someone wants to remove the text about devfs being obsolete
till udev is actually ready for use?

Regards, Andreas

