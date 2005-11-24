Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVKXEkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVKXEkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVKXEkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:40:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751328AbVKXEka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:40:30 -0500
Date: Wed, 23 Nov 2005 23:40:10 -0500
From: Dave Jones <davej@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
Message-ID: <20051124044009.GE30849@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com> <cone.1132788250.534735.25446.501@kolivas.org> <200511232335.15050.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232335.15050.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:35:15PM +0000, Alistair John Strachan wrote:
 > On Wednesday 23 November 2005 23:24, Con Kolivas wrote:
 > > Chen, Kenneth W writes:
 > > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
 > > >
 > > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
 > > >
 > > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
 > >
 > >                        ^^^^^^^^^^
 > >
 > > Please try to reproduce it without proprietary binary modules linked in.
 > 
 > AFAIK "G" means all loaded modules are GPL, P is for proprietary modules.


The 'G' seems to confuse a hell of a lot of people.
(I've been asked about it when people got machine checks a lot over
 the last few months).

Would anyone object to changing it to conform to the style of
the other taint flags ? Ie, change it to ' ' ?

		Dave

