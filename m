Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTDYX77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTDYX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:59:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27921 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263365AbTDYX76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:59:58 -0400
Message-ID: <3EA9CEB2.7090804@zytor.com>
Date: Fri, 25 Apr 2003 17:11:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <459930000.1051302738@[10.10.2.4]> <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]> <3EA9B061.600@techsource.com> <3280000.1051308382@[10.10.2.4]> <3EA9C19E.9020205@zytor.com> <10000000.1051312797@[10.10.2.4]>
In-Reply-To: <10000000.1051312797@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 
> Right ... I was just suggesting changing it by default. Was wondering if
> anyone knew of anything it'd break. Your issue with NULL pointers is
> interesting, but I'm not sure this would really affect that much ... the
> stack is normally tiny in comparison.
> 

Normally, yes, but there are applications which use very large stacks.

	-hpa


