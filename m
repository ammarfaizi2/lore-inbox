Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUC0XRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUC0XRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:17:35 -0500
Received: from vvv.conterra.de ([212.124.44.162]:31108 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S261932AbUC0XRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:17:33 -0500
Message-ID: <40660B75.7000605@conterra.de>
Date: Sun, 28 Mar 2004 00:17:09 +0100
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfsd oops with 2.6.5-rc2-mm4 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Denis wrote:

> Version 3. I can give version 2 a try but there will probably
> a significant loss of performance :(

probably better than a total loss of performance :-)

> Unfortunately this is a production environment and I can hardly
> switch the Solaris box off in order to make it sure that it is
 > triggering the bug.

Same here. I set up a NFS-server for test and let the Sun
mount the data in a temporary directory to verify the situation.
The test-server may crash, but the sun will survive. After you
stopped the test on the sun, you might have to reboot your
test-server to be able to unmount the disk on the sun again.

>> I reverted to 2.6.2-rc2-mm3, the server didn't crash after 6 hours. Crossing fingers... 
> 
> Pointless.
> 
> 2.6.2-rc2-mm3 just crashed the same way.

Yes, all 2.6.x seem to be affected. My good old 2.4.19 runs since 6 month.
I started to scan the 2.5.x patches for changes on nfsd, to find by which
one this kind of trouble was caused....

Dieter.
