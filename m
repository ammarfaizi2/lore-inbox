Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbTILPhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTILPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:37:36 -0400
Received: from saspace.sas.be ([195.207.19.1]:36878 "EHLO
	saspace.spaceapplications.com") by vger.kernel.org with ESMTP
	id S261739AbTILPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:37:35 -0400
Message-ID: <3F61E83E.402@abcpages.com>
Date: Fri, 12 Sep 2003 17:37:34 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tcpdump equivalent for the serial port
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm interested if somebody has any ideea how to write a program that is able to sniff the data passing through a serial port the same way tcpdump is able to show the data passing through the ethernet cable, i.e. without disturbing the application that sends/receives the data.
I've seen few programs that basically work as tunnels opening a pseudo-console where the application connects and writing on the other side to the serial device. This approach is not very useful because I want to be able to start/stop my sniffer without interupting the communication and also the application can control different settings of the serial port which probably will not be forwarded by the tunnel.
Another sugestion was to monitor rather the application using ptrace than the serial port itself but this has the inconvenience that I only get the data when the application reads it not when it arrives.
I wonder if there is any support provided in the kernel for this.

Thanks,
mache


