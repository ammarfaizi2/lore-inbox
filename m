Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRB1PKw>; Wed, 28 Feb 2001 10:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbRB1PKm>; Wed, 28 Feb 2001 10:10:42 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:22356 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130208AbRB1PK0>;
	Wed, 28 Feb 2001 10:10:26 -0500
Message-ID: <20010228161023.A19929@win.tue.nl>
Date: Wed, 28 Feb 2001 16:10:23 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Glenn McGrath <bug1@optushome.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au>; from Glenn McGrath on Wed, Feb 28, 2001 at 08:52:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 08:52:54PM +1100, Glenn McGrath wrote:

> Im running kernel 2.4.1, I have entries like /proc/ide/hda,
> /proc/ide/ide0/hda etc irrespective of wether im using devfs or
> traditional device names.
> 
> Is always using traditional device names for /proc/ide intentional, or
> is it something nobody has gotten around to fixing yet?

If only humans look at /proc, and they like typing long names,
then there is no objection against changing /proc.
As it is, however, quite a few programs look at /proc for
information about devices. I don't think it would be a good
idea to "fix" /proc and simultaneously break all these programs.
