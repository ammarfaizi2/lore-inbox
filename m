Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSDWRAe>; Tue, 23 Apr 2002 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315270AbSDWRAd>; Tue, 23 Apr 2002 13:00:33 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:24248 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315266AbSDWRAc>; Tue, 23 Apr 2002 13:00:32 -0400
Message-ID: <3CC591AA.3561D419@austin.ibm.com>
Date: Tue, 23 Apr 2002 11:54:02 -0500
From: James L Peterson <peterson@austin.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: paulus@samba.org, anton@au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
In-Reply-To: <15553.12447.849592.261245@argo.ozlabs.ibm.com>
		<3CC41AC6.BD8E32E4@austin.ibm.com>
		<15557.5295.921549.964163@argo.ozlabs.ibm.com> <20020423.011432.86512016.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does this mean?  This suggests that PCI controller for
big-endian systems are not interchangable with PCI controllers
for little-endian systems, because the controller itself does
byte swapping (is that what you mean by "byte twisting"?)

jim



"David S. Miller" wrote:

> An important point to mention is that big endian systems need to do
> byte twisting in the PCI controller for all the byte-lane issues to
> work out properly.
>

