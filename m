Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTHHIZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 04:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTHHIZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 04:25:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26777 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270448AbTHHIZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 04:25:33 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 8 Aug 2003 10:25:30 +0200 (MEST)
Message-Id: <UTC200308080825.h788PUC07523.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Cc: andries.brouwer@cwi.nl, jasper@vs19.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see a general trend there.
> I tend to prefer favor/color etc. Oh, and disk obviously.

Yes, disk obviously.
Otherwise the score is divided.

% gryp neighbour | wc -l
581
% gryp neighbor | wc -l
389

% gryp colour | wc -l
285
% gryp color | wc -l
1844

% gryp favour | wc -l
33
% gryp favor | wc -l
71

% gryp zeroes | wc -l
206
% gryp zeros | wc -l
391

Hmm. The neighbours win, but otherwise it is mostly American.
Since it is not overwhelmingly but only mostly American
it may be a bad idea to start "fixing" this. The patch
would be too large.
