Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVIQOAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVIQOAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 10:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIQOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 10:00:20 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:45444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbVIQOAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 10:00:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=itW2ci5fHB7do0ie4ulaY8hEOOlAiBI315QpxOc0CKufjwWmaOZ9KPYNh40EHao3VXoVmHjD3cUZ6njvWQAfpumEVrl6MDpkYAZZ18P1hcfT+K7p8xQIDiejckRMjDsNysUa+TcuimBCvgDVc5OITXugTYMHB2Nl8KSDJSjpgpY=
Message-ID: <432C2169.2090300@gmail.com>
Date: Sat, 17 Sep 2005 23:00:09 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [QUESTION] The cost of local interrupt enable/disable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, guys.

  I'm curious about the cost of local_irq_enable/disable()'s on various 
architectures.  I found a freebsd discussion thread by googling which 
says that each takes 3 cycles on i386 (very cheap), but for Pentium4, 
people are talking in the order of several hundreds cycles.  Are these 
correct?  How about other architectures?

  TIA.

-- 
tejun
