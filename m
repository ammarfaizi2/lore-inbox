Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbUDPWMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUDPWEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:04:05 -0400
Received: from linux.us.dell.com ([143.166.224.162]:47217 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263886AbUDPWBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:01:36 -0400
Date: Fri, 16 Apr 2004 16:59:58 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix edd driver dereferencing before pointer checks.
Message-ID: <20040416215958.GA30606@lists.us.dell.com>
References: <20040416204948.GH20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416204948.GH20937@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 09:49:48PM +0100, Dave Jones wrote:
> Lots of occurences of the same bug..
> -	struct edd_info *info = edd_dev_get_info(edev);

Ouch!  Good catch Dave.  Thanks!

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
