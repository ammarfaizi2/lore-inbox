Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUASSIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUASSIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:08:53 -0500
Received: from bgp01038448bgs.sothwt01.mi.comcast.net ([68.43.98.24]:38277
	"EHLO fire-eyes.dynup.net") by vger.kernel.org with ESMTP
	id S262131AbUASSIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:08:32 -0500
Message-ID: <400C1D2F.7020503@fire-eyes.dynup.net>
Date: Mon, 19 Jan 2004 13:08:47 -0500
From: fire-eyes <sgtphou@fire-eyes.dynup.net>
Reply-To: sgtphou@fire-eyes.dynup.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing some strange behavior using kernel 2.6.1 and a Belkin KVM. I 
have talked to two others who have seen the same problem. This did not 
happen in 2.6.0 or any 2.4 kernel.

When switching ports using the keyboard, that is hitting scroll lock 
twice and then the port # I want ( 1 - 16), then coming back the same 
way, I often get the following error:

kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).

I have also seen this same error while switching from X11 to console, 
but only once. In that one case, I lost mouse control, and keyboard 
control, and was unable to regain either. I had to reboot to rectify the 
situation.

I'm not sure if this happens when pushing the buttons on the front of 
the kvm.

KVM Information:

Belkin Omniview Matrix2 , Model F1DM216T
Maufacturer URL: 
http://catalog.belkin.com/IWCatProductPage.process?Merchant_Id=1&Product_Id=122933

Is there any further information I can submit to help solve this?
