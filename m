Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272497AbTGaPF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272503AbTGaPF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:05:58 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:39121 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272497AbTGaPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:05:57 -0400
Date: Thu, 31 Jul 2003 08:05:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <59140000.1059663916@[10.10.2.4]>
In-Reply-To: <200307280548.53976.efocht@gmx.net>
References: <200307280548.53976.efocht@gmx.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you're using node_to_cpu_mask for ia64 ... others were using 
node_to_cpumask (1 less "_"), so this doesn't build ...

M.

