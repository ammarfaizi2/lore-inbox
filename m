Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUFKUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUFKUDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUFKUDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 16:03:37 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:28835 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S264348AbUFKUDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 16:03:35 -0400
Message-ID: <40CA4848.7070509@drdos.com>
Date: Fri, 11 Jun 2004 18:03:20 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP NFS to Novell does not work
References: <20040611185156.GA26757@thumper2>
In-Reply-To: <20040611185156.GA26757@thumper2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you using a remote NetWare server running the NFS Server NLM with 
NFSv3 from Linux? Try compiling the kernel with NFSv3 disabled and use 
NFSv2 instead.

Jeff



Andy wrote:

>Using kernel 2.4.26, I am unable to copy large files to novell over TCP
>NFS.  It copies part of the file, the I get a "stale NFS file handle" error. 
>I can then delete the file on novell over NFS without a problem.  I do not
>have this problem coping to a tru64 mount.
>
>UDP works, but I get corruption in the file.  Which I shouldn't get.
>
>Andy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


