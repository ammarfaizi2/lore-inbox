Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDIBOZ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTDIBOZ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:14:25 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:6418 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S262657AbTDIBOT (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:14:19 -0400
Date: Wed, 9 Apr 2003 03:25:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030409010250.GZ31739@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0304090316070.5042-100000@serv>
References: <20030408195305.F19288@almesberger.net>
 <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
 <b6vnig$q86$1@cesium.transmeta.com> <Pine.LNX.4.44.0304090225440.12110-100000@serv>
 <20030409010250.GZ31739@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Apr 2003, Joel Becker wrote:

> 1) Ship 2.6 with 16bit dev_t, work on a larger dev_t and perfect dynamic
>    devices in 2.7.
> 2) Ship 2.6 with a (32|64)bit dev_t, work on a perfect dynamic scheme in
>    2.7.
> 3) Hold 2.6 until it can ship with (32|64)bit dev_t and perfect dynamic
>    devices.
> 
> 	Many folks, Peter and myself included, are claiming that choice
> (1) is absolutely untenable.  We need more device space today, not in 3
> years when 2.7 becomes 2.8.
> 	If I understand you correctly (and here is why I mailed), you
> feel that choice (2) is the worst of the choices.  You feel that we
> should either choose course (1) or course (3).  I'm not sure which of
> those you prefer.

That misunderstanding is hopefully easy to resolve:

(4) Ship 2.6 with a (32|64)bit dev_t with an experimental dynamic scheme 
and keep the device numbers below 0x10000 as they are now.

bye, Roman

