Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVKXEjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVKXEjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVKXEjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:39:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751315AbVKXEjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:39:00 -0500
Date: Wed, 23 Nov 2005 23:38:28 -0500
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
Message-ID: <20051124043828.GD30849@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <200511232333.jANNX9g23967@unix-os.sc.intel.com> <cone.1132788946.360368.25446.501@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1132788946.360368.25446.501@kolivas.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 10:35:46AM +1100, Con Kolivas wrote:
 > Chen, Kenneth W writes:
 > 
 > >Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
 > >>Chen, Kenneth W writes:
 > >>
 > >>> Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
 > >>> 
 > >>> Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
 > >>> 
 > >>> Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
 > >
 > >Also, isn't it 'P' indicate proprietary module, not 'G'?
 > >line 159: kernel/panic.c:
 > >
 > >        snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
 > >                tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
 > 
 > Sorry it's not proprietary module indeed. But what is tainting it?
 
'B' = bad page ;)

		Dave

