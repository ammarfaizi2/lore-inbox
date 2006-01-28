Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWA1QRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWA1QRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWA1QRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:17:38 -0500
Received: from bay104-f39.bay104.hotmail.com ([65.54.175.49]:32141 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751451AbWA1QRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:17:37 -0500
Message-ID: <BAY104-F39ABA84D32B83FBC0ABDE8C0170@phx.gbl>
X-Originating-IP: [216.221.71.212]
X-Originating-Email: [kamrankarimi@hotmail.com]
In-Reply-To: <S1751463AbWA1QJL/20060128160911Z+539@vger.kernel.org>
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Porting DIPC (Distributed IPC) to Linux 2.6
Date: Sat, 28 Jan 2006 10:17:37 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jan 2006 16:17:37.0415 (UTC) FILETIME=[5A9BB970:01C62426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

DIPC (Distributed IPC) makes the system V IPC's shared memories, semaphores, 
and messages work transparently over the network for easy data transfer 
among distributed applications.

A package containing an unfinished port of DIPC to 2.6 kernels 
(dipc-2.1-alpha1.tgz) can be found here: 
http://www.cs.uwindsor.ca/~kamran/downloads.html in the DIPC section.

The user-space tools and the kernel compile, but no tests have been done. 
Also, due to changes in 2.6 kernels, some of the code in DIPC's shm.c code 
has been commented out, so the shared memory won't work for now.

Any contribution in this effort is greatly appreciated.

-Kamran Karimi


