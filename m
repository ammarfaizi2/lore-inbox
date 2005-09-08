Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVIHPfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVIHPfH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVIHPfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:35:07 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:37547 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932535AbVIHPfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:35:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n+zAymSz4Axu2EKb+C2QGY5plinmo/a6aX4QKHAOJfuKh1gMuBB91jiWMIWZTM/p5fwmAsEbbNDlyoR+KDM/udLkh4GWORUHiMlcWNcoRkTlMZ6wQA0xzJ6I41GhvI5lTIwKE0tLzaBEtWa1bPPdlA3vrhKAM7WNvtaQPsTgrUU=
Message-ID: <5d0f6099050908083510aa9ab4@mail.gmail.com>
Date: Thu, 8 Sep 2005 17:35:02 +0200
From: Dirk Jagdmann <jagdmann@gmail.com>
Reply-To: jagdmann@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Ethernet IP multicast maximum packet size
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developers,

I googled around all day, but did not find any satisfying answer. Is
there a maximum packet size when I use IP multicasting in a local
ethernet LAN? Or more precisely, does the multicast code in Linux
handle an IP fragmentation/defragmentation of a 63K UDP multicast
datagram, which is transmitted over an 1500bytes MTU ethernet? Or
should I stay on the safe edge and don't construct datagrams > 1500 so
I'll avoid fragmentation?

-- 
---> Dirk Jagdmann
----> http://cubic.org/~doj
-----> http://llg.cubic.org
