Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUCHWCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCHWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:02:42 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:18124 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261351AbUCHWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:01:56 -0500
Date: Mon, 8 Mar 2004 23:01:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: lvm2 performance data with linux-2.6
Message-ID: <20040308220153.GB19977@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200403081916.i28JGgE25794@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403081916.i28JGgE25794@mail.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2004, markw@osdl.org wrote:

> I've started collecting various data (including oprofile) using our
> DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
> ia64 platforms:
> 	http://developer.osdl.org/markw/lvm2/
> 
> So far I've only varied the stripe width with lvm, from 8 KB to 512 KB,
> for PostgreSQL that is using 8 KB sized blocks with ext2.  It appears

Does ext2 write 8 KByte sized blocks atomically on IA32?

Or is this no requirement for PostgreSQL consistency?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
