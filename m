Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTHUNox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTHUNnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:17 -0400
Received: from zork.zork.net ([64.81.246.102]:17359 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262670AbTHUM77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:59:59 -0400
To: "John Newbie" <john_r_newbie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe remove request_module("scsi_hostadapter"); from ->
References: <Law14-F46r7An1P78E00005323d@hotmail.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "John Newbie" <john_r_newbie@hotmail.com>,
 linux-kernel@vger.kernel.org
Date: Thu, 21 Aug 2003 13:59:53 +0100
In-Reply-To: <Law14-F46r7An1P78E00005323d@hotmail.com> (John Newbie's
 message of "Thu, 21 Aug 2003 16:47:48 +0400")
Message-ID: <6uada3np2u.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Newbie" <john_r_newbie@hotmail.com> writes:

>>Consider IDE systems with SCSI peripherals and SCSI built modular.
>
> In my opinion the best solution is to surround
> request_module("scsi_hostadapter");
> with
> #ifdef CONFIG_SCSI_MODULE
> in addition to CONFIG_KMOD
>
> Agree?

There already exists a solution, which is to alias scsi_hostadapter to
off.

