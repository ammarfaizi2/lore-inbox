Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWGPLQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWGPLQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWGPLQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 07:16:20 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:56981 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751567AbWGPLQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 07:16:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cv2BDZUXMVavaWq+fumu/PXM+T8cSpIXVUiMdrZX8L0Xk67seFM2kkP617OEi6TjEe/7wUcaS6H/JILahChZ44Q5kr3JGes7EF+DkMvXD+RrpnFSYy6YcE/NGN5rCzgs/i3/QKkRZ/0/JoDvO4pn3bDr4PO3aC7+YqNLi+m9Srk=
Message-ID: <6bffcb0e0607160416w7b1c9a01oc04236856cbfc007@mail.gmail.com>
Date: Sun, 16 Jul 2006 13:16:10 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catherine Zhang" <cxzhang@watson.ibm.com>
Subject: Re: kernel memory leak fix for af_unix datagram getpeersec
Cc: linux-kernel@vger.kernel.org, catalin.marinas@gmail.com,
       czhang.us@gmail.com, "James Morris" <jmorris@namei.org>,
       "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <20060716045731.GA303@jiayuguan.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060716045731.GA303@jiayuguan.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catherine,

On 16/07/06, Catherine Zhang <cxzhang@watson.ibm.com> wrote:
>
> Hi, Catalin and Michal,
>
> Enclosed please find the patch against 2.6.18-rc1 that fixed the kernel
> memory leak problem.

I still get a lot of memory leak reports.

[michal@ltg01-fedora ~]$ cat /tmp/ml1.txt | grep -c
selinux_socket_getpeersec_dgram
802
[michal@ltg01-fedora ~]$ cat /tmp/ml2.txt | grep -c
selinux_socket_getpeersec_dgram
816

>
> Thanks for your help!
> Catherine

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
