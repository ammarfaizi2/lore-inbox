Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTHNCqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272148AbTHNCqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:46:46 -0400
Received: from www.opensource-ca.org ([168.234.203.30]:21768 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S272144AbTHNCqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:46:45 -0400
Date: Wed, 13 Aug 2003 20:41:29 -0600
To: Alasdair McWilliam <allymcw2000@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Message-ID: <20030814024129.GB1539@guug.org>
References: <LAW10-F56d2h2jXi2Qd0001e84d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW10-F56d2h2jXi2Qd0001e84d@hotmail.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 02:02:02AM +0100, Alasdair McWilliam wrote:
> 1. PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP 
> system

you must save your .config to another dir, then make mrproper,
then move your .config to your source tree, then make normally.

happens to me when i had an intel configured source tree, then
compile for amd.

-solca

