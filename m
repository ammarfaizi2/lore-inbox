Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVAPKf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVAPKf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAPKf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:35:29 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:57367 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262475AbVAPKfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EFtD9/8Y+YTgNWvTkiUlFrE3ZhF54Z8UKlIlzkX5ThFq5ZEgJybpksejvvwnnRlXhZumKN0bM5sBGy0rNHKpAvO21wEHOuAZXrhsba8+NJD9NTovSE2NR94Urr0U+wiw92ZvdWW0FzZXxE3Oy8wUmxKyTD6uEr8EysmJOvBlHak=
Message-ID: <9e47339105011602354bdbd92e@mail.gmail.com>
Date: Sun, 16 Jan 2005 05:35:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997050116020859687c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be sure and run with "modprobe drm debug=1" and check the debug
output. If it is broken the debug output will say the card is AGP. The
message from the X server does not mean anything for DRM, you need to
check the debug output from DRM.

-- 
Jon Smirl
jonsmirl@gmail.com
