Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUD3IKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUD3IKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUD3IKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:10:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264843AbUD3IKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:10:05 -0400
Message-ID: <409209D0.2040704@pobox.com>
Date: Fri, 30 Apr 2004 04:09:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: adi@hexapodia.org, pj@sgi.com, vonbrand@inf.utfsm.cl,
       nickpiggin@yahoo.com.au, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	<20040429133613.791f9f9b.pj@sgi.com>	<20040429141947.1ff81104.akpm@osdl.org>	<20040429143403.35a7a550.pj@sgi.com>	<20040429145725.267ea7b8.akpm@osdl.org>	<20040430000408.GA29096@hexapodia.org>	<20040429173223.3ea4d0c5.akpm@osdl.org>	<409205C1.7000700@pobox.com> <20040430010213.65e6048e.akpm@osdl.org>
In-Reply-To: <20040430010213.65e6048e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
>> Does our fadvise support len==0 ("I mean the whole file")?  That's 
>> defined in POSIX, and would allow a compliant app to simply 
>> POSIX_FADV_DONTNEED once at the beginning.
> 
> 
> Well I'll be darned.


FWIW the specific language is "If len is zero, all data following offset 
is specified."

(for others, you probably already have this somewhere)
http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html

top level SuSv3:
http://www.opengroup.org/onlinepubs/007904975/toc.htm

	Jeff



