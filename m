Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUBBJsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUBBJsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:48:16 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:1535 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S265708AbUBBJsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:48:11 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
Organization: OEZK, CAU Kiel
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: page allocation failed in 2.4.24
Date: Mon, 2 Feb 2004 10:47:17 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402010018.23725.mgabriel@ecology.uni-kiel.de> <Pine.LNX.4.58L.0402012151510.2331@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402012151510.2331@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200402021047.17722.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo,

> How much swap do you have on this system and how much swap space is free
> when you start seeing the allocation failures?

oh yes, when i rebooted the host yesterday, i saw a glimpse of

  swap device /dev/XXX has no swap signature (or similar)

in the kernel-message.

i did a 

  mkswap /dev/XXX; swapon /dev/XXX

and now the system works fine (for now...)

thanks for your reply,
mike

> "vmstat 2" output (start it before running the tests) and "cat
> /proc/slabinfo" output (before and during the tests) are useful to find
> out what is happening.

thanks for this info!

-- 

netzwerkteam - oekologiezentrum
Mike Gabriel
FA Geobotanik
Christian-Albrecht Universit‰t zu Kiel
Abt. Prof. Dr. K. Dierﬂen
Olshausenstr. 75
24118 kiel

fon-oezk: +49 431 880 1186
fon-home: +49 431 64 74 196

mail: mgabriel@ecology.uni-kiel.de
http://www.ecology.uni-kiel.de

