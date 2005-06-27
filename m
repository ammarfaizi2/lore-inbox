Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVF0VoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVF0VoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0VnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:43:16 -0400
Received: from isilmar.linta.de ([213.239.214.66]:58340 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261889AbVF0Vmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:42:53 -0400
Date: Mon, 27 Jun 2005 23:42:49 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Haninger <ahaning@gmail.com>
Cc: Jim serio <jseriousenet@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X not recognizing second CPU
Message-ID: <20050627214249.GA29657@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Haninger <ahaning@gmail.com>,
	Jim serio <jseriousenet@gmail.com>, linux-kernel@vger.kernel.org
References: <3642108305062711524e1e163@mail.gmail.com> <105c793f050627123583a70d0@mail.gmail.com> <3642108305062713487326b672@mail.gmail.com> <105c793f05062714022ad4359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f05062714022ad4359@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 05:02:37PM -0400, Andrew Haninger wrote:
> On 6/27/05, Jim serio <jseriousenet@gmail.com> wrote:
> > Thanks for the reply. I think it was a typo but just in case I did try
> > acpi=force and still no go.
> I've not used SMP systems much, but AFAIK, power management is not
> supported. (Though, I guess ACPI is used for stuff other than power
> savings.) Maybe acpi=off?

a) Power Management is available on SMP, though support for it is a bit less
   wide-spread than it is for UP

b) ACPI stands for Advanced _Configuration_ and Powermanagement Interface.
   For SMP and especially SMT (e.g. HyperThreading) on x86, it is essential
   for proper system set-up.

	Dominik
