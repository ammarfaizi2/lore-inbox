Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284570AbRLPJyM>; Sun, 16 Dec 2001 04:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284573AbRLPJyD>; Sun, 16 Dec 2001 04:54:03 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:54466 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S284570AbRLPJxv>; Sun, 16 Dec 2001 04:53:51 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Bradley D. LaRonde" <brad@ltc.com>, "Thomas Capricelli" <orzel@kde.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <0ddd01c184b3$ce15c470$5601010a@prefect>
	<066801c183f2$53f90ec0$5601010a@prefect>
	<20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
	<25867.1008323156@redhat.com> <13988.1008348675@redhat.com>
Organisation: SAP LinuxLab
In-Reply-To: <13988.1008348675@redhat.com>
Message-ID: <m3r8pw7rsb.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
Date: 16 Dec 2001 10:51:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 14 Dec 2001, David Woodhouse wrote:
> Adding the pages to the page cache on read_inode() is fairly
> simple. Hacking the kernel so that readpage() can provide its own
> page less so.

But would make mm/shmem.c much simpler while adding functionality.

Greetings
		Christoph


