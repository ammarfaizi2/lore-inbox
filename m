Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSKHN04>; Fri, 8 Nov 2002 08:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSKHN0z>; Fri, 8 Nov 2002 08:26:55 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:59091 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S261908AbSKHN0z>; Fri, 8 Nov 2002 08:26:55 -0500
Message-ID: <3DCBBCDA.3050203@torque.net>
Date: Sat, 09 Nov 2002 00:32:10 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sscanf("-1", "%d", &i) fails, returns 0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lk 2.5.46-bk3 the expression in the subject line
fails to write into "i" and returns 0. Drop the minus
sign and it works.

Doug Gilbert

