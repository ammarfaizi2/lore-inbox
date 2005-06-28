Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVF1M5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVF1M5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVF1M5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:57:22 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:36837 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261451AbVF1M5N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cmBPiDMuafOM4NLDsJzOd8bFaEBiSkp7DoL6YbIbUw0kkku9BsQV0lkTb/Epwgu16cCYcN60itTljU21hJOr6Dsi3U0o/t0tK3jQ7J2LVYG5aRCRRsEQA6OTB5P6kxQJ0vq1fkPKmnkiqTpBxTQVeb8DnBG2458NTan/fEKcaAk=
Message-ID: <dc849d8505062805573a73ec99@mail.gmail.com>
Date: Tue, 28 Jun 2005 20:57:04 +0800
From: cigarette Chan <benbenshi@gmail.com>
Reply-To: cigarette Chan <benbenshi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: route trouble with kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i add a route to the kernel
eg: # route add -net XXX.XXX.XXX.XXX/24 gw XXX.XXX.XXX.XXX dev eth1

but after i restart eth1

#ifdown eth1
#ifup eth1

the route disappear,this make me a lot of troubles.i have several
interfaces,and i have to
re-add all of these routes...

Is there any way or patches to make route work like iptables,after i
restart the interface,
rules  are still there.
