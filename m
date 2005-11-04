Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKDU1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKDU1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKDU1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:27:40 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:42433 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750806AbVKDU1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:27:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=eAVgpSqEUjcxUZkb7/sgIhNut5YKBlCaNmHM+AeH0kIfg5NO8L7SijPqr66ou3eqasRM0459+nW2dzEszAQmuK+xC8tXZH1++WdUqloiP5OB4QIk+K9RQIO2bjAwkJKGumUzBN7ybWWaSimCSYyWbUPGP3nfRStJ7aX3Ou2l11A=
Message-ID: <436BC42B.1050804@gmail.com>
Date: Fri, 04 Nov 2005 20:27:23 +0000
From: Ram Gupta <ram.gupta5@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: negative timeout can be set up by setsockopt system call
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observed that the the setsockopt system call can  setup negative 
timeout. As a matter of fact the function sock_set_timeout checks for 
zero timeout but does not check for negative timeouts. I tested this 
against 2.6.14  kernel but it is so in all previous release also. So I 
am wondering if it is a bug or there is some reason for keeping it that 
way which I am missing.

Regards
Ram gupta
