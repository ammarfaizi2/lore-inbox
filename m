Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSBFKiO>; Wed, 6 Feb 2002 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290377AbSBFKiE>; Wed, 6 Feb 2002 05:38:04 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:39308 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S290338AbSBFKhz>; Wed, 6 Feb 2002 05:37:55 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16YFou-0003Nm-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: Wed, 06 Feb 2002 11:36:56 +0100
In-Reply-To: <E16YFou-0003Nm-00@the-village.bc.nu> (Alan Cox's message of
 "Wed, 6 Feb 2002 00:20:16 +0000 (GMT)")
Message-ID: <m3ofj2galz.fsf@linux.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, 6 Feb 2002, Alan Cox wrote:
>> So, you should ponder whether it is worthwhile to pay this cost of
>> zero, and ponder whether it is worthwhile to pay this cost of 5 kB.
> 
> If you are going to cat it onto the end of the kernel image just
> mark it __initdata and shove a known symbol name on it. It'll get
> dumped out of memory and you can find it trivially by using tools on
> the binary

What about putting such info into a (swappable) tmpfs file with
shmem_file_setup?

Greetings
		Christoph


