Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTD0RcL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 13:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbTD0RcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 13:32:11 -0400
Received: from codepoet.org ([166.70.99.138]:140 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264709AbTD0RcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 13:32:10 -0400
Date: Sun, 27 Apr 2003 11:44:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030427174424.GA17680@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
References: <20030424093443.GA7180@codepoet.org> <20030427122104.GK10256@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427122104.GK10256@fs.tum.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Apr 27, 2003 at 02:21:04PM +0200, Adrian Bunk wrote:
> Looking at the only user of this function it seems we can completely 
> remove it (patch below).
> 
> Alan:
> Is the patch below OK or are there any future plans for more uses of
> idedisk_supports_host_protected_area?
> 
> >  -Erik

Looks fine to me.  Even better,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
