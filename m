Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVC1MEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVC1MEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVC1MEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:04:44 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:31452 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261422AbVC1MEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:04:39 -0500
Message-ID: <4247F2AA.7070201@ens-lyon.org>
Date: Mon, 28 Mar 2005 14:03:54 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: Fix mode setting on CRT monitors
References: <1111969496.5409.40.camel@gaston>
In-Reply-To: <1111969496.5409.40.camel@gaston>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt a écrit :
> Hi !
> 
> Current radeonfb is a bit "anal" about accepting CRT modes, it basically only
> accepts modes that have the exact resolution, which tends to break with fbcon
> on console switches as it provides "approximate" modes. This patch fixes it
> by having the driver chose the closest possible mode instead of looking for
> an exact match.

Hi Benjamin,

I tried your patch because on recent -mm kernels I see dirty colored 
columns during a few seconds when switching from X to radeon fbcon
(looks like remaining colors of X).
I don't know what visible effect your patch is supposed to have.
I didn't see any difference, but I doesn't seem to break anything.

Regards,
Brice
