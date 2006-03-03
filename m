Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWCCXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWCCXOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCCXN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:13:59 -0500
Received: from sneakemail.com ([38.113.6.61]:40427 "HELO monkey.sneakemail.com")
	by vger.kernel.org with SMTP id S932252AbWCCXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:13:59 -0500
Date: Fri, 03 Mar 2006 18:12:16 -0500
From: "Chuck Martin" <v4b1bze02@sneakemail.com>
Subject: Realtime Kernel Slows My Clock
To: linux-kernel@vger.kernel.org
Message-ID: <28925-53282@sneakemail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently been trying to compile a realtime kernel for audio
work, and am having a problem.  The clock seems to run very slow,
causing my time to be off.  Commands with a delay are also slowed
from 10 to 30 times what they should be.  For example, "sleep 1"
will sometimes take up to thirty seconds.

I originally tried both patch-2.6.15-rt12 and patch-2.6.15-rt16
applied to both kernel 2.6.15 and 2.6.15.2, and after having no luck
with them, I tried patch-2.6.15-rt1 applied to kernel 2.6.15, and all
of them gave the same results, but both of these kernels work fine
unpatched.  I've since tried a number of older patched kernels, and it
seems the problem originated with patch-2.6.13-rt13 (patch-2.6.13-rt12
does not exhibit the problem).

I've brought this up on the linux-audio-users mailing list, and no one
seems to know what the problem might be.  It was suggested that I post
my problem to this list (and CC Ingo Molnar), which is why I'm here.
Does anyone have any ideas what the problem might be?  I'm not
subscribed to the list (I would, but I don't know if I want that much
e-mail at the moment), so please CC me with any replies.  Thanks.

Chuck

