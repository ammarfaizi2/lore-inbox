Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314470AbSEHPZ3>; Wed, 8 May 2002 11:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314471AbSEHPZ1>; Wed, 8 May 2002 11:25:27 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:52650 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314470AbSEHPYv>; Wed, 8 May 2002 11:24:51 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 question: Can a process have > 3GB memory?
In-Reply-To: <Pine.LNX.4.44L.0205072155220.32261-100000@imladris.surriel.com> <191939915.1020845530@[10.10.2.3]>
From: Andi Kleen <ak@muc.de>
Date: 08 May 2002 17:24:27 +0200
Message-ID: <m3u1pi7jdg.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:
> 
> How are you going to change the user page tables from userspace?
> This mechanism would seem to need kernel support however you did it.

You mmap/munmap files in tmpfs. 

That is what tmpfs was developed for by SAP.

-Andi
