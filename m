Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310507AbSCLJgw>; Tue, 12 Mar 2002 04:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310531AbSCLJgm>; Tue, 12 Mar 2002 04:36:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48392 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S310521AbSCLJgg>; Tue, 12 Mar 2002 04:36:36 -0500
Message-ID: <3C8DCBD9.D6A3A1E9@aitel.hist.no>
Date: Tue, 12 Mar 2002 10:35:21 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.5-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308231405.CADDC3FE06@smtp.linux.ibm.com> <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com> <a6bjgl$a0j$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:

> 
> Okay, I'll say it and be impopular...
> 
> Perhaps it's time to drop i386 support?
> 
Wouldn't it be better to just separate it out?  I.e. make i386
an arch of its own, while most pc people use a "486 and up" arch?

The few who actually want 386 code won't loose it, and other developers
won't have to bother with 386 issues.  Then drop the 386 arch when it
dies from lack of maintenance...

Helge Hafting
