Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbTDDMSe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTDDMLI (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:11:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25736
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263690AbTDDMFV (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 07:05:21 -0500
Subject: Re: How to fix the ptrace flaw without rebooting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304040622_MC3-1-32FC-81F2@compuserve.com>
References: <200304040622_MC3-1-32FC-81F2@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049454936.2150.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Apr 2003 12:15:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-04 at 12:18, Chuck Ebbert wrote:
> Erik Hensema wrote:
> 
> 
> > A better fix in a running system is to simply disable dynamic module
> > loading: echo /no/such/file > /proc/sys/kernel/modprobe
> 
> 
>  You mean like this?
> 
>    # echo 'x'>/proc/sys/kernel/modprobe
>    bash: /proc/sys/kernel/modprobe: No such file or directory

Thats not a sufficient fix except for people blindly running the
example exploit

