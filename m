Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbTCGQYw>; Fri, 7 Mar 2003 11:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbTCGQYv>; Fri, 7 Mar 2003 11:24:51 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:43410 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S261646AbTCGQYu>; Fri, 7 Mar 2003 11:24:50 -0500
Message-ID: <3E68CA48.2090905@cox.net>
Date: Fri, 07 Mar 2003 09:35:20 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 449] New: Kernel BUG when tun device is closed
References: <302800000.1047015141@[10.10.2.4]>
In-Reply-To: <302800000.1047015141@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=449
> 
>            Summary: Kernel BUG when tun device is closed (oops attached)
>     Kernel Version: 2.5.64
>             Status: NEW
>           Severity: normal
>              Owner: mochel@osdl.org
>          Submitter: kpfleming@cox.net
> 
> 
> Distribution: heavily modified RedHat 7.3
> Hardware Environment: MSI K7T266-Pro2 motherboard, Athlon Thunderbird 1GHz CPU,
> (2) WD1600JB disks, etc.
> Software Environment: vtund-2.5
> Problem Description: vtund works fine normally (is in client mode on this
> system). when the server end of the link was shutdown, the client tried to close
> its open "tun" device. this action caused the oops below.
> 

I have already updated this bug to show that Patrick's patch posted 
yesterday appears to solve the problem.

