Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313768AbSDHVvw>; Mon, 8 Apr 2002 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313769AbSDHVvv>; Mon, 8 Apr 2002 17:51:51 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:19590 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313768AbSDHVvv>; Mon, 8 Apr 2002 17:51:51 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 8 Apr 2002 14:56:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.44.0204081456120.1498-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:

> Hi!
>   I have a script that is using the /cpu/procinfo file to determine the
> number of cpus present in the system. But I would like to implement it
> using a system call rather than use the environment variables?? I
> couldn't find a system call for linux that would give me the result.
> Could anyone please let me know if there is one for redhat linux??

sysconf(_SC_NPROCESSORS_CONF);




- Davide


