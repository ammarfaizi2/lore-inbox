Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWCBP7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWCBP7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCBP7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:59:34 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:48468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751038AbWCBP7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UsXKQzDbJoVGb983YIZN3w/ilijQvbqCHK7by3Lo4Ah4eK8DjJJWIYikIyzA5ofMwHiuorjkuwxL4mMwB95CrnD4B3DjMS1vCZW2lw4hq6mLxU3bcNYhuwoZMPNad8Md+JC12ApOVoY2ocDqMLtmV+rUDr6R87rToFaYUmtuHyc=
Message-ID: <9e4733910603020759m10545cd1va3ef67398f1f38ea@mail.gmail.com>
Date: Thu, 2 Mar 2006 10:59:33 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Compenstating for clock drift
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my logs I can see that my system clock is consistently drifting
about 3 seconds every 24hrs and ntp is faithfully correcting it.  Can
the kernel track long term data like this and insert/remove a few
extra ticks to minimize the size of the ntp drift corrections?

--
Jon Smirl
jonsmirl@gmail.com
