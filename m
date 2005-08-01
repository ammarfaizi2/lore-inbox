Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVHAPTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVHAPTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVHAPTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:19:46 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:25510 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261288AbVHAPSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:18:50 -0400
Message-ID: <42EE3D56.7050008@f2s.com>
Date: Mon, 01 Aug 2005 16:18:46 +0100
From: Bernd Porr <BerndPorr@f2s.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NZG <ngustavson@emacinc.com>
CC: comedi@comedi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6VMM, uClinux, & Comedi
References: <200508010817.59676.ngustavson@emacinc.com>
In-Reply-To: <200508010817.59676.ngustavson@emacinc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks quite promising. I would like to run comedi on a blackfin stamp. 
Please keep me in the loop.

/Bernd

www:    http://www.berndporr.me.uk/
         http://www.linux-usb-daq.co.uk/
Mobile: +44 (0)7840 340069
Work:   +44 (0)141 330 5237
         University of Glasgow
         Department of Electronics & Electrical Engineering
         Room 519, Rankine Building, Oakfield Avenue,
         Glasgow, G12 8LT


NZG wrote:
> I managed to successfully cross-compile Comedi for the Coldfire uClinux 2.6, 
> however it has several unresolved symbols when I try to load it.
> 
> comedi: Unknown symbol pgd_offset_k
> comedi: Unknown symbol pmd_none
> comedi: Unknown symbol remap_page_range
> comedi: Unknown symbol pte_present
> comedi: Unknown symbol pte_offset_kernel
> comedi: Unknown symbol VMALLOC_VMADDR
> comedi: Unknown symbol pte_page
> 
> Apparently uClinux isn't implementing these paged memory functions,which
> kind of makes sense, but I'm a little fuzzy on what the nommu code is
> supposed to be doing exactly, and I couldn't find any documentation on what 
> these functions are doing in the vanilla 2.6 kernel.
> Has anyone else been down this road before?
> I found Mel Gorman's Thesis on the 2.4 mm functions, but I couldn't find most 
> of these symbols in it.
> It's looking like the 2.6 mm stuff is still pretty undocumented, any links to 
> documentation (or short text explanations)would be appreciated. 
> 
> thx.
> NZG.
> 
> _______________________________________________
> comedi mailing list
> comedi@comedi.org
> https://cvs.comedi.org/cgi-bin/mailman/listinfo/comedi
