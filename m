Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVA3PFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVA3PFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVA3PFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:05:21 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:51478 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261708AbVA3PFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:05:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=anqyZMAkoksQF8q0/akTw5gsyz71SGWKnM6C7gH/BYdNHHVidx/lutaUU1xvmbt+GMA0XG6UlyP2nWEFJa0CE2ofVr/l8uPdOMKOqDXwTfohb6ki+3IYgA8xYJd0O9awisvjaFiu88i5Lze/ZA2Tklz6A22iV8fyFkjFeZ2ETk0=
Message-ID: <9e473391050130070520631901@mail.gmail.com>
Date: Sun, 30 Jan 2005 10:05:16 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970501300322ffdabe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just checked out on current Linus BK with my AGP Radeon 9000 which
is pretty close to a 9200. Everything is working fine.

I notice from his logs that he is running a PCI radeon, not an AGP
one. Didn't someone make some changes to the PCI radeon memory
management code recently? I run a PCI R128 and that is still working.
DRM debug output might give more clues.

-- 
Jon Smirl
jonsmirl@gmail.com
