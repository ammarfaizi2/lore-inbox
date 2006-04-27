Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWD0Llo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWD0Llo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWD0Lln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:41:43 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:9695 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964986AbWD0Lln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:41:43 -0400
Date: Thu, 27 Apr 2006 13:41:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/16] ehca: InfiniBand query and multicast functionality
Message-ID: <20060427114104.GA32127@wohnheim.fh-wedel.de>
References: <4450A17D.4030708@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A17D.4030708@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some small stuff.

On Thu, 27 April 2006 12:48:29 +0200, Heiko J Schick wrote:
> 
> + *  This source code is distributed under a dual license of GPL v2.0 and 
> OpenIB

Line wrap.  You might want to check your mailer or switch to a
different one.

> +		return (-EINVAL);

Remove brackets.

> +	if (H_SUCCESS != hipz_rc) {

To frown upon reversed grammar, I tend.  Hard to understand, such code
is.

With a decent compiler, there is zero advantage to put the constant
first - assuming you don't ignore warnings.  But it makes the code
just as hard to read as the Yoda-speak above.

> +	return retcode;

People tend to use the shorter "ret" or "err".

Jörn

-- 
You can take my soul, but not my lack of enthusiasm.
-- Wally
