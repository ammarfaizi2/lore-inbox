Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271408AbTG2LJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTG2LJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:09:02 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:41865
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S271408AbTG2LIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:08:53 -0400
Date: Tue, 29 Jul 2003 07:24:40 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729072440.A12426@animx.eu.org>
References: <20030728225947.GA1694@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030728225947.GA1694@localhost.localdomain>; from Balram Adlakha on Tue, Jul 29, 2003 at 04:29:48AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot transfer files larger than 914 mb from an NFS mounted
> filesystem to a local filesystem. A larger file than that is
> simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> works fine. Can it be the version of mount I'm using? Its the
> one that comes with util-linux-2.11y.

I noticed on 2.6.0-test1 that mounting a server using the userspace nfs
daemon (v2 I assume) doesn't work very well at all.  It was pretty much
useless.  I rarely ever could get a directory listing.  It would just spew
"nfs server not responding".

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
