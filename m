Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269941AbTGSLPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 07:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269977AbTGSLPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 07:15:15 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:45626 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269941AbTGSLPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 07:15:13 -0400
Message-ID: <3F198C66.1030405@netcabo.pt>
Date: Sat, 19 Jul 2003 19:22:30 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with mii-tool && 2.6.0-test1-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jul 2003 11:25:09.0597 (UTC) FILETIME=[699A30D0:01C34DE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I compile the 8139 ethernet support as a module (as I always did - 
module name >> 8130too) I will get an error in make modules_install. 
However, if I build it in the kernel it will work just fine. The problem 
is that now when I try to do a simple mii-tool -F 100baseTX-FD eth0 
(because my eth always stats at 100 Half duplex) I get this error:

SIOCGMIIPHY on 'eth0' failed: Operation not supported

What should I do?

PR

