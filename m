Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131273AbRC0NOL>; Tue, 27 Mar 2001 08:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRC0NNv>; Tue, 27 Mar 2001 08:13:51 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:10631 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131273AbRC0NNr>; Tue, 27 Mar 2001 08:13:47 -0500
From: Christoph Rohland <cr@sap.com>
To: Alex Riesen <vmagic@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tmpfs: a way to get your system down
In-Reply-To: <20010324182908.B1255@steel>
Organisation: SAP LinuxLab
In-Reply-To: <20010324182908.B1255@steel>
Message-ID: <m31yrj74a7.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 27 Mar 2001 15:10:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sat, 24 Mar 2001, Alex Riesen wrote:
> just hit by tmpfs on 2.4.2-ac20
> 
> mount -t tmpfs mnt
> dd if=/dev/zero mnt/tmpfile
> 
> resulted in hardly slowed system and lockup,
> and not in "No space left on device", as expected.

Use mount option "size". The default is unlimited...

Greetings
		Christoph


