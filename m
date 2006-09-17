Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWIQCaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWIQCaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 22:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWIQCaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 22:30:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:6431 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964932AbWIQCaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 22:30:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kvSQ4ZEgG5GDPjd9CER8zauAMobdc0+Tfy3y7FDDr4UuUhND1tj2zlgwNko0o59IJhCrdZLJODqVhma7gBhIrKby1MoNhJ7jKIXN9aWGpFfNNXypykeo9X3YcNLtEO3yCZ8ywnMZaP2Broyb2OJn9HFxdxt6GvIgnw/ljDoxKmk=
Message-ID: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
Date: Sun, 17 Sep 2006 14:30:16 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Crash on boot after abrupt shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We are using linux in quite a harsh mobile environment (high
temperatures, unreliable power sources, electrical interference, etc).

It has been doing very well, except for this scenario. The wireless
interface wlan0 is busy communicating, and the power is disconnected
abruptedly. In the next boot, we get a kernel panic when the wlan
interface is initialised.

We want to know if this is due to linux's journaling file system (we
are using ext3)? Does it keep track of the state so closely, even up
to the point of the previous abrupt shutdown? If so, what can we do to
"cleanup" in the next boot to avoid the kernel panic?

Regards
Keith
