Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVBKHnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVBKHnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBKHkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:40:19 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:63136 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262211AbVBKHbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:31:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=K4d8Sw3h+X+5ssXez4Z1NggLEuhWfrTWUUn9m57YI5t5q4FHy6S6W0GBov2QG390OVpSvjIOtkf3IIb1CW04mZeE2+hcwJG+iYhWSt5oKUboZuwUaBtH1+xlRuZfPiF5VLPE+UL0ao8A44dX2yR9gfle9MBrAcql2TNJS7Rmmaw=
Message-ID: <420C5F3F.9060105@gmail.com>
Date: Fri, 11 Feb 2005 16:31:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [UTILITY] lksp - Help sending patches to lkml from quilt repository
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

 As I've been making quite a few mistakes posting patches to lkml.  I
wrote a perl script which automates sending multiple patches to lkml
from a quilt repository.

 lksp can...

 1. generate template index message.
 2. use only specified range of patches from the quilt repository.
 3. use the edited index message to generate individual patch mail
messages combined with patches acquired from quilt.
 4. keep all patch descriptions you wrote and reuse them.
 5. let you blame the script if something goes wrong and you end up
polluting other people's inbox.

 More information on lksp can be found at
 http://home-tj.org/lksp

 And the script can be downloaded from
 http://home-tj.org/lksp/files/lksp-0.1

 If you've found bugs or have any ideas, please let me know.

 Hope it helps. :-)

-- 
tejun

