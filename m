Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHSHBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHSHBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHSHBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:01:21 -0400
Received: from holomorphy.com ([207.189.100.168]:57277 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261426AbUHSG7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:59:14 -0400
Date: Wed, 18 Aug 2004 23:59:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-ID: <20040819065909.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com,
	alan@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org,
	riel@redhat.com, sct@redhat.com
References: <20040818235523.383737cd@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818235523.383737cd@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:55:23PM -0700, Pete Zaitcev wrote:
> The PF_MEMALLOC is required on usb-storage threads in 2.4, because ext3
> will deadlock and otherwise misbehave when it's trying to write out
> dirty pages under memory pressure.
> I received a bug report today from an FC3T1 user with same symptoms
> as 2.4. But I'm entirely clueless in the way VM operates. Comments?

I suspect this describes it adequately. If the shoe fits...


-- wli
