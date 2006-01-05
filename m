Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWAEMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAEMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWAEMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:17:09 -0500
Received: from mail.gmx.net ([213.165.64.21]:48080 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752172AbWAEMRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:17:08 -0500
X-Authenticated: #4368190
Message-ID: <43BD0E1C.9060705@gmx.de>
Date: Thu, 05 Jan 2006 13:16:28 +0100
From: =?ISO-8859-1?Q?Hans-J=FCrgen_Lange?= <Hans-Juergen.Lange@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.x on IBM thin client 8363 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to run a 2.6.x kernel on a IBM thin client 8363. There are 
patches available for the 2.4 series of kernels.
I had a look on these patches and the only thing they do is to expand 
the kernel commandline size to 512 Bytes and a change in 
arch/i386/kernel/head.S that changed the pointer to the commandline to a 
fixed address.

In the 2.4.kernel the kernel parameter and command line are ,,moved out 
of the way''  in two steps. And the second step is the one that get patched.
In the 2.6 kernel this is done in one step. I did get an explanation of 
the startup code for the 2.4. kernel but not for the 2.6. I believe that 
it is no problem to make the changes to get the IBM 8363 running.

I have seen that some people use this machine but all what use the 
newest kernel.

If someone could help me to understand what is going on in the startup 
code or may have a ready to use solution for this problem it would be 
very nice if you could help with get it running.

BR
Hans-Juergen Lange
