Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUGNCk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUGNCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 22:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUGNCk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 22:40:28 -0400
Received: from holomorphy.com ([207.189.100.168]:46745 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267302AbUGNCkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 22:40:25 -0400
Date: Tue, 13 Jul 2004 19:40:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040714024020.GS21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089771823.15336.2461.camel@abyss.home>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:23:44PM -0700, Peter Zaitsev wrote:
> To be honest I was truly surprised seeing OOM killer killing MySQL
> without any good reason during highly IO intensive test:
> Out of Memory: Killed process 19301 (mysqld).
> Out of Memory: Killed process 19302 (mysqld).
> Out of Memory: Killed process 19303 (mysqld).
> Out of Memory: Killed process 19304 (mysqld).
> Out of Memory: Killed process 19305 (mysqld).
> Out of Memory: Killed process 19306 (mysqld).
> Out of Memory: Killed process 19309 (mysqld).
> Out of Memory: Killed process 19310 (mysqld).
> Out of Memory: Killed process 19311 (mysqld).
> Out of Memory: Killed process 19312 (mysqld).
> Out of Memory: Killed process 19737 (mysqld).
> Out of Memory: Killed process 19739 (mysqld).
> Out of Memory: Killed process 19821 (mysqld).
> This box has 4G memory and running without swap (what I would need it
> for If I can only use up to 3GB address space in the application anyway)

Is this a regression from earlier 2.6 versions? Do you have an isolated
testcase (obviously I should be able to install mysql easily) I can use
to trigger this?


-- wli
