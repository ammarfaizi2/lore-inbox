Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbRB1KbR>; Wed, 28 Feb 2001 05:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRB1KbH>; Wed, 28 Feb 2001 05:31:07 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:24837 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129614AbRB1Kay>; Wed, 28 Feb 2001 05:30:54 -0500
Message-ID: <3A9CD2F3.E26A2884@idb.hist.no>
Date: Wed, 28 Feb 2001 11:29:07 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Glenn McGrath <bug1@optushome.com.au>, linux-kernel@vger.kernel.org
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn McGrath wrote:
> 
> Im running kernel 2.4.1, I have entries like /proc/ide/hda,
> /proc/ide/ide0/hda etc irrespective of wether im using devfs or
> traditional device names.
> 
> Is always using traditional device names for /proc/ide intentional, or
> is it something nobody has gotten around to fixing yet?

Using devfs changes the names in /dev.  I don't think it
is supposed to affect /proc in any way.  And there are programs out
that use the existing /proc - changing it won't be popular.

Helge Hafting
