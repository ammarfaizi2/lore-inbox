Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUIIO2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUIIO2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUIIO2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:28:03 -0400
Received: from jade.spiritone.com ([216.99.193.136]:60095 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S264704AbUIIO2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:28:00 -0400
Date: Thu, 09 Sep 2004 07:27:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <564620000.1094740068@[10.10.2.4]>
In-Reply-To: <20040907141741.58174cfd.akpm@osdl.org>
References: <544180000.1094575502@[10.10.2.4]> <20040907141741.58174cfd.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, the good news is that it compiles now, and without forcing ACPI on.
>>  Yay!
> 
> Does it boot?

Yup. Performance is the same as other -mm's (scheduler changes bring it
down from mainline quite a bit, but otherwise OK).

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                2.6.9-rc1       44.97       98.66      576.77     1501.33
            2.6.9-rc1-mm1       46.92      107.27      594.10     1493.67
            2.6.9-rc1-mm2       46.95      107.80      593.65     1493.33
            2.6.9-rc1-mm4       46.93      108.91      593.19     1495.00

M.

