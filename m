Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbSIWCeH>; Sun, 22 Sep 2002 22:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbSIWCeH>; Sun, 22 Sep 2002 22:34:07 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:21087 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264909AbSIWCeH>; Sun, 22 Sep 2002 22:34:07 -0400
Message-ID: <3D8E7EBD.2080004@blue-labs.org>
Date: Sun, 22 Sep 2002 22:38:53 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sending pkt_too_big ... to self
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 833; timestamp 2002-09-22 22:39:15, message serial number 360799
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self

Every day I get several thousand of these.  How is this kernel figuring 
the pmtu is 1492?  eth0 is 1500 (lo is ~ 16k).  All routes are either 
default, 1500, or 1400 with an advmss of 900.

Connections tend to break when this floods the console.

David


