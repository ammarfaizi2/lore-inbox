Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268016AbUHKKEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268016AbUHKKEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHKKEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:04:40 -0400
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:24843 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S268016AbUHKKEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:04:39 -0400
Message-ID: <4119EF1D.2040102@tuxbox.org>
Date: Wed, 11 Aug 2004 12:04:13 +0200
From: Florian Schirmer <jolt@tuxbox.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de> <200408101228.27455.gene.heskett@verizon.net> <20040811002455.GA7537@merlin.emma.line.org>
In-Reply-To: <20040811002455.GA7537@merlin.emma.line.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The switch from read mode to write mode (i. e. find end of data,
>increase LASER power to write and pick up writing) takes some time
>(order of magnitude: µs) which means some pits/lands aren't right during
>that phase. How many pits/lands are broken break depends on hard- and
>firmware, write speed and model and for CAV the radial position on the
>disc. Fast writers will need to reach a linear velocity around 60 m/s
>(216 km/h); one µs time to ramp up LASER power from read to write level
>there means up to 60 µm lost.
>

With burn-proof on you get a disc which is still usable but with some 
pits/lands missing/misplaced. With burnproof off you get a completely 
unusable disc. So whats the _real_ point behind disabling burn proof?

Thanks,
   Florian
