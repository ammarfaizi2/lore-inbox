Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266042AbVBDVQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbVBDVQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbVBDVQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:16:32 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:21329 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266249AbVBDVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=h4POMFKvMoKCdemncthdnsT/ggXHECxhIwZQ0ck1x2UdUPOwUSMuwS1MgZFUp+jGakOifFIpRB+hGdYAzCS+QO2gCvYuoP4qMOmqtaUGWBVr7Pd77Ndp5C0g0gqIXhQtYSxx7Yh+y2z7mU9lktUE71CSgohMN+d1yPY3stOE2ls=
Message-ID: <9e47339105020413141c1570ec@mail.gmail.com>
Date: Fri, 4 Feb 2005 16:14:45 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: nonexistant HPET timer and sysfs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think I have a HPET timer (3 year old 2.8Ghz P4). But when I
have HPET enabled in the kernel  I get a sysfs entry and consequently
a /dev/hpet entry. Should the HPET device be created if I don't have
the hardware? My expectation was that the sysfs entry should not have
been created. Is there a simple way to check if a box has a HPET
timer?

-- 
Jon Smirl
jonsmirl@gmail.com
