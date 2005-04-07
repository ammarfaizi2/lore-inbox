Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVDGTdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVDGTdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVDGTdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:33:16 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:54957 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S262573AbVDGTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:33:14 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.30: pwc pwc_isoc_handler() called with status -84
References: <x6ekdqgyfm@gzp> <20050405135552.GB7409@logos.cnet>
	<20050406170746.048e5b58@lembas.zaitcev.lan>
Date: Thu, 07 Apr 2005 21:33:11 +0200
Message-ID: <x64qeiidqg@gzp>
User-Agent: Gnus/5.110003 (No Gnus v0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pete Zaitcev <zaitcev@redhat.com>:

| > > pwc Too many ISOC errors, bailing out.
| > > pwc pwc_isoc_handler() called with status -84 [CRC/Timeout (could be anything)].
| 
| There is no other way but to start splitting patches and diff-ing.
| We can narrow this down a little by looking at what _might_ be involved.
| Is this device driven by EHCI?

yes, i think so. Asus P4C800-E mobo. Details in the tarball.

| A snapshot of /proc/bus/usb/devices would be useful (BTW, Gabor,
| please do it on both 2.4.28 and 2.4.30-rc).

Right now I have .30-rc only: http://gzp.odpn.net/tmp/pwc/pwc.tgz
I should compile a new 2.4.28, because I deleted...
