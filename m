Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSG2Lb4>; Mon, 29 Jul 2002 07:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSG2Lb4>; Mon, 29 Jul 2002 07:31:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44789 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315282AbSG2Lb4>;
	Mon, 29 Jul 2002 07:31:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Jul 2002 13:35:10 +0200 (MEST)
Message-Id: <UTC200207291135.g6TBZAZ15815.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, martin@dalecki.de
Subject: Re: [PATCH] partition fix
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > The patch below does two things:
    > 
    > (i) fixes a small bug in the new partition code
    > This is the final chunk s/n/slot/. I'll refrain from giving a vi script.
    > This is uncontroversial.
    > 
    > (ii) removes ancient garbage concerning disk managers
    > This may well be controversial.

    The disk managers where kludgy garbage in first place.
    And nowadays I agree with you: It's not worth to dragg it around.

Indeed. But the change will generate some noise.
People will get assigned a somewhat different disk geometry
in many cases and will need some education (or a new fdisk)
to keep them from worrying.

Andries

