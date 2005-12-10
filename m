Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVLJPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVLJPno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 10:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLJPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 10:43:44 -0500
Received: from 80-219-218-68.dclient.hispeed.ch ([80.219.218.68]:55196 "EHLO
	mx.eriadon.com") by vger.kernel.org with ESMTP id S932638AbVLJPnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 10:43:43 -0500
From: Edmondo Tommasina <edmondo@eriadon.com>
To: Tom <harningt@gmail.com>
Subject: Re: Linux 2.6.15-rc5: off-line for a week
Date: Sat, 10 Dec 2005 16:43:39 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200512041526.19111.edmondo@eriadon.com> <dndkaj$27f$2@sea.gmane.org>
In-Reply-To: <dndkaj$27f$2@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512101643.39777.edmondo@eriadon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10-December-2005 05:07, Tom wrote:
> Edmondo Tommasina wrote:
> > Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
> >        <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
> >        <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
> >        <ffffffff8010dcaa>{system_call+126}
> > (...)
> 
> I get that too... compiles and mostly works.

These are just harmless warnings saying that the some unnamed module ;-) is
doing some strange VMA remapping. It's expected to be like that.

Look at the "Linux 2.6.14-rc4" thread to better understand the changes
done:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0512.0/0010.html

ciao
edmondo
