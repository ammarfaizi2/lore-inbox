Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274030AbRISJ61>; Wed, 19 Sep 2001 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274029AbRISJ6R>; Wed, 19 Sep 2001 05:58:17 -0400
Received: from maclaurence.math.u-psud.fr ([129.175.50.15]:16903 "EHLO
	maclaurence") by vger.kernel.org with ESMTP id <S273350AbRISJ6N>;
	Wed, 19 Sep 2001 05:58:13 -0400
Date: Wed, 19 Sep 2001 11:59:17 +0200
To: linux-kernel@vger.kernel.org
Subject: min/max and all that jazz
Message-ID: <20010919115917.A12129@maclaurence.math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Duncan Sands <duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc has a warning option -Wsign-compare (not turned on by -Wall):

`-Wsign-compare'
     Warn when a comparison between signed and unsigned values could
     produce an incorrect result when the signed value is converted to
     unsigned.  This warning is also enabled by `-W'; to get the other
     warnings of `-W' without this warning, use `-W -Wno-sign-compare'.

This might pick up some errors of the kind the new min/max macros
are trying to catch...

Duncan.

PS: please CC any comments to me, since I'm not subscribed to the list.
