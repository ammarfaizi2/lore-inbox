Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUJLOwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUJLOwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUJLObS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:31:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:29550 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264991AbUJLOaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:30:35 -0400
Message-ID: <35fb2e5904101207304a5b4c8d@mail.gmail.com>
Date: Tue, 12 Oct 2004 15:30:34 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Jan Hudec <bulb@ucw.cz>
Subject: Re: Kernel stack
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
In-Reply-To: <20041012094104.GM703@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com>
	 <46561a790410112351942e735@mail.gmail.com>
	 <20041012094104.GM703@vagabond>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004 11:41:04 +0200, Jan Hudec <bulb@ucw.cz> wrote:

> The base of the stack does not have to be stored either, because it is
> AT FIXED OFFSET from the task_struct! If you don't believe me, look at
> definition of the current macro. It says just (%esp & ~8195) (it says it
> in assembly, because you can't directly access registers from C, and it
> uses some macros that mean "two pages" instead of 8195).

The pedant in me wants to point out that 8K is 0-8191 and not 0-8195 :-)

Jon.
