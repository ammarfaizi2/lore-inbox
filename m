Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRCTVjZ>; Tue, 20 Mar 2001 16:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRCTVjP>; Tue, 20 Mar 2001 16:39:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130831AbRCTVjL>; Tue, 20 Mar 2001 16:39:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux should better cope with power failure
Date: 20 Mar 2001 13:38:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <998ijs$ord$1@cesium.transmeta.com>
In-Reply-To: <3FA68C00B3E3A3418373DA6446330DD30328E0@spike.i405.net> <3AB68A91.9785A9D0@bluewin.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3AB68A91.9785A9D0@bluewin.ch>
By author:    Otto Wyss <otto.wyss@bluewin.ch>
In newsgroup: linux.dev.kernel
> 
> It was just a simple test machine where it didn't matter what was lost.
> Still that doesn't justify this behaviour.
> 

Then use a journalling filesystem.  If not, give it a few minutes of
idle time; fsck will complain on boot but it should be able to clean
up the mess.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
