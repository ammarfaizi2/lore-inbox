Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTI3TE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTI3TE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:04:27 -0400
Received: from codepoet.org ([166.70.99.138]:5254 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261680AbTI3TEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:04:11 -0400
Date: Tue, 30 Sep 2003 13:04:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andreas Steinmetz <ast@domdv.de>, axboe@suse.de,
       schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930190410.GB5407@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"David S. Miller" <davem@redhat.com>,
	Andreas Steinmetz <ast@domdv.de>, axboe@suse.de,
	schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930052337.444fdac4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930052337.444fdac4.davem@redhat.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 30, 2003 at 05:23:37AM -0700, David S. Miller wrote:
> Suggest changes to fix the problems, but just saying "don't include
> kernel header in your user apps, NYAH NYAH NYAH!" does not help
> anyone at all.

Until someone gets off their butt and assembles a set of user
space kernel headers, the correct answer is "don't include kernel
headers, instead make private copies of the needed kernel defines
and structs and fixup the kernel types to use C99 types from
stdint.h"

I.e. do for yourself what the kernel folk have not done,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
