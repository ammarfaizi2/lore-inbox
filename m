Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVDDTAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVDDTAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDDTAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:00:20 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:3533 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S261331AbVDDTAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:00:06 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: 2.4.30: pwc pwc_isoc_handler() called with status -84
Date: Mon, 04 Apr 2005 20:59:57 +0200
Message-ID: <x6ekdqgyfm@gzp>
User-Agent: Gnus/5.110003 (No Gnus v0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Philips 750 webcam camera, equipped with a
Sony CCD sensor + TDA878.

It was working fine with 2.4.29 and earlier kernels, often with
100-150 days uptime.

As I upgraded to 2.4.30-rc kernels, started getting such error in my
kernel log:

pwc Too many ISOC errors, bailing out.
pwc pwc_isoc_handler() called with status -84 [CRC/Timeout (could be anything)].

[khubd] got 100% cputime, and kernel just printed and printed this
message to the log, generating huge files. :-)

rc4 is still doing this. 1-2 hour online, the something get mad and
the pwc driver eat the cputime. 2.4.28 was 100% okay from this point
of view.

http://gzp.odpn.net/tmp/pwc/
