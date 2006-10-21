Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423364AbWJURZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423364AbWJURZo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423365AbWJURZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:25:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:52897 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423364AbWJURZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:25:43 -0400
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Chris Largret <largret@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1, timebomb?
References: <200610200130.44820.gene.heskett@verizon.net>
	<20061020212244.56f9f02b@localhost>
	<200610210037.57871.gene.heskett@verizon.net>
From: Andi Kleen <ak@suse.de>
Date: 21 Oct 2006 19:25:35 +0200
In-Reply-To: <200610210037.57871.gene.heskett@verizon.net>
Message-ID: <p731wp1mvhs.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:
> 
> ISTR that was the second time an un-logged powerdown has been done since 
> that kernel became the default.  

It might be overheating. During a critical overheat condition the
ACPI code will just power off. It should still get console messages
out (but nothing on disk), so if you configure serial or net console
you would see a message.

And check your fans are ok.

-Andi
