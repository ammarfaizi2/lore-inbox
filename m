Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKSHaP>; Mon, 19 Nov 2001 02:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRKSHaF>; Mon, 19 Nov 2001 02:30:05 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:56730 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S272818AbRKSH3r>; Mon, 19 Nov 2001 02:29:47 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: "Norberto Bensa" <nbensa@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs?
In-Reply-To: <003a01c16fe5$088ae9c0$0200000a@home>
Organisation: SAP LinuxLab
In-Reply-To: <003a01c16fe5$088ae9c0$0200000a@home>
Message-ID: <m3elmwjqqb.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 19 Nov 2001 08:29:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Norberto,

On Sun, 18 Nov 2001, Norberto Bensa wrote:
> I've configured my kernel (2.4.13-ac8) to use tmpfs, but it seems
> that it only uses half my physical memory (64 of 128MB).

,----[ Configure.help ]
| Virtual memory file system support
| CONFIG_TMPFS

[...]

|   You can set limits for the number of blocks and inodes used by the
|   filesystem with the mount options "size", "nr_blocks" and
|   "nr_inodes". These parameters accept a suffix k, m or g for kilo,
|   mega and giga and can be changed on remount.
|   
|   The initial permissions of the root directory can be set with the
|   mount option "mode".
`----

So the configure help gives you the answer: Use the size mount
option.

Greetings
		Christoph


