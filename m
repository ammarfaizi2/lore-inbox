Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTENRSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTENRSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:18:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45141 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262623AbTENRSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:18:23 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4 (machine_power_off returning causes problems)
References: <8570000.1052623548@[10.10.2.4]>
	<20030510224421.3347ea78.akpm@digeo.com>
	<8880000.1052624174@[10.10.2.4]>
	<20030510231120.580243be.akpm@digeo.com>
	<12530000.1052664451@[10.10.2.4]>
	<m17k8x72ir.fsf_-_@frodo.biederman.org>
	<19660000.1052710226@[10.10.2.4]> <m11xz45lqk.fsf@frodo.biederman.org>
	<22080000.1052743429@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 May 2003 11:27:44 -0600
In-Reply-To: <22080000.1052743429@[10.10.2.4]>
Message-ID: <m1addp4ewf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> Well, yes ... but I'm not trying to use kexec, just doing an init 0 ;-)
> That worked fine before.

Just a last thought with my updated patch init 0 will continue to work
because it does not return machine_halt now.

Unless there was some magic I am missing.

