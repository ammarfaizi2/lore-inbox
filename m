Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTHHDWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTHHDWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 23:22:51 -0400
Received: from quechua.inka.de ([193.197.184.2]:26550 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271184AbTHHDWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 23:22:50 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4 2/2] add hw_random RNG driver
In-Reply-To: <20030808025502.GA31909@gtf.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19kxq4-0004ou-00@calista.inka.de>
Date: Fri, 08 Aug 2003 05:22:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030808025502.GA31909@gtf.org> you wrote:
> +       bits the RNG circuitry will enter a low power state. Intel will
> +       provide a binary software driver to give third party software
> +       access to our RNG for use as a security feature. At this time,
> +       the RNG is only to be used with a system in an OS-present state.

this part is confusing, seems it does not apply to linux kernel?

> +       hardware is faulty or has been tampered with).  Data is only
> +       output if the hardware "has-data" flag is set

where is the flag coming from, where can one read it? What happens if no
data is present, will it block?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
