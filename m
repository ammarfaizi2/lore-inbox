Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSKOFxe>; Fri, 15 Nov 2002 00:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKOFxe>; Fri, 15 Nov 2002 00:53:34 -0500
Received: from vitelus.com ([64.81.243.207]:15370 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S265830AbSKOFxd>;
	Fri, 15 Nov 2002 00:53:33 -0500
Date: Thu, 14 Nov 2002 22:00:17 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Tim Hockin <thockin@sun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021115060017.GF15812@vitelus.com>
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com> <3DD44742.2DFE4407@digeo.com> <3DD44CC0.40805@sun.com> <3DD44E39.4703C2DA@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD44E39.4703C2DA@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 05:30:33PM -0800, Andrew Morton wrote:
> - add `char groups[16]' to task_struct
> 
> - add `struct page *groups_page' to task_struct

Wouldn't it be better to use a union to save space?
