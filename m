Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUKNVx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUKNVx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUKNVx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 16:53:58 -0500
Received: from lakermmtao12.cox.net ([68.230.240.27]:4323 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261339AbUKNVx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 16:53:56 -0500
Message-ID: <4197D3F9.2080008@ksu.edu>
Date: Sun, 14 Nov 2004 15:54:01 -0600
From: Andrew Ruder <aeruder@ksu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ANN: Trustees linux for the 2.6 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have ported Vyacheslav Zavadsky's work with trustees 
(http://trustees.sourceforge.net) to the Linux security module API.

Trustees is an advanced Linux permission system inspired by Netware. It 
allows a system administrator to attach "trustees" to any directory or 
file. All subdirectories and files in that directory will also inherit 
these trustees. Trustee rights can be overridden, denied or added to in 
subsequent directories.

In short, it is a recursive directory-based replacement for POSIX acls. 
   All permissions are managed from a central file and thus allows even 
filesystems (network, vfat, etc.) without extended attribute support to 
have an advanced permission scheme. It should compile against any 
version of the 2.6 kernel with CONFIG_SECURITY enabled (it currently 
compiles as just an external module).

Please see my website for more information:
    http://www.aeruder.net/trustees/

Download:
    http://www.aeruder.net/trustees/download.php?download=current

Documentation:
    http://www.aeruder.net/trustees/documentation.php?download=current

I have been using it for a couple weeks with no problems, but your 
mileage may vary.  The code still needs some cleanups, and I need to 
figure out how to do some benchmarking on the performance hit, but I 
would very much so appreciate feedback, bug-reports, etc.

Thanks and I am not on the list so please Cc any replies,
Andrew Ruder
