Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSIIKQ3>; Mon, 9 Sep 2002 06:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSIIKQ3>; Mon, 9 Sep 2002 06:16:29 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:49568 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317091AbSIIKQ2>; Mon, 9 Sep 2002 06:16:28 -0400
Message-ID: <3D7C761A.7090806@earthlink.net>
Date: Mon, 09 Sep 2002 05:21:14 -0500
From: Ashby <ironicface@earthlink.net>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Module idea
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had an idea to potentially improve security, and I think it
might be best implemented as a kernel module.

Since buffer problems are a common network (and other) security
risk, why not create a Buffer Manager (similar to PAM, in the 
authentication domain), to handle all buffer requests with the
outside world?

If the manager existed after the tcp/ip stack, and before any processes
needing buffer input, then it could store the whole data as returned
by the tcp/ip stack.

When a process requests a buffer, it asks by (net) address, and includes 
a buffer length. The buffer manager returns the appropriate amount of
data to the process, and then clears the address. The buffer manager
could also be set to log buffer overruns.

Have a good day/evening,

R. Ashby
ironicface -at- earthlink -dot- net

