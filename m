Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbTF1TIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTF1TIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:08:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43658
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265342AbTF1TIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:08:25 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, davidel@xmailserver.org, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030627.172123.78713883.davem@redhat.com>
References: <3EFCC1EB.2070904@candelatech.com>
	 <20030627.151906.102571486.davem@redhat.com>
	 <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk>
	 <20030627.172123.78713883.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:19:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 01:21, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 28 Jun 2003 00:08:56 +0100
> 
>    Tried doing an SQL query or text analysis for similarities on random
>    messages lurking in private mailboxes
> 
> I respond to private reports with "please send this to the lists,
> what if I were on vacation for the next month?"  I never actually
> process or analyze such reports.

Which means you miss stuff. Here is an example my tools found yesterday

18 months ago someone with a specific printer reported doing network printing
to it crashed the kernel. Lost in the noise, filed in bugzilla, categorised 
mentally at the time as "weird".

Not long ago a second identical report popped up. Different setup, same
network printing, similar "it reboots" report.

So now I've gone chasing tcpdumps from these.

Its a *different* thing to the kind of patch management you are doing, but its
only possible because of tools like bugzilla

