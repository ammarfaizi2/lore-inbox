Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWECPsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWECPsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbWECPsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:48:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60364 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965234AbWECPsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:48:05 -0400
Subject: Re: [patch 1/1 17-rc3-mm1] generic-time: add macro to
	simplify/hide mask constants
From: john stultz <johnstul@us.ibm.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4458CA7A.1080203@gmail.com>
References: <4458CA7A.1080203@gmail.com>
Content-Type: text/plain
Date: Wed, 03 May 2006 08:48:44 -0700
Message-Id: <1146671325.3432.1.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 11:21 -0400, Jim Cromie wrote:
> This patch compiles clean, and is running and maintaining ntp lock
> (across ethernet to a laptop).  I've verified (with objdump) that
> macro reduces to constant at compile-time. Also compile-tested with 
> allnoconfig.  Please consider for -mm.
> 
> ---
> 
> From: Jim Cromie <jim.cromie@gmail.com>
> Date: Wed May  3 10:59:00 EDT 2006
> 
> 
> Add a CLOCKSOURCE_MASK macro to simplify initializing the mask for 
> a struct clocksource, and use it to replace literal mask constants
> in the various clocksource drivers.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>


Looks like a nice change to me. 

thanks
-john

Acked-by: John Stultz <johnstul@us.ibm.com>



