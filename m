Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933610AbWKWLQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610AbWKWLQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933613AbWKWLQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:16:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41617 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933610AbWKWLQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:16:31 -0500
Date: Thu, 23 Nov 2006 11:21:42 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Conke Hu" <conke.hu@amd.com>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-ID: <20061123112142.3c6916d6@localhost.localdomain>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 12:20:37 +0800
"Conke Hu" <conke.hu@amd.com> wrote:

> 
> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch will make SB600 SATA run in AHCI mode even if it was set as IDE mode by system BIOS.
> 
> Signed-off-by: conke.hu@amd.com

Acked-by: Alan Cox <alan@redhat.com>
