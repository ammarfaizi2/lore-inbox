Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263041AbREWJkh>; Wed, 23 May 2001 05:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263042AbREWJk1>; Wed, 23 May 2001 05:40:27 -0400
Received: from ns.suse.de ([213.95.15.193]:46096 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263041AbREWJkJ>;
	Wed, 23 May 2001 05:40:09 -0400
Date: Wed, 23 May 2001 11:39:14 +0200
From: Andi Kleen <ak@suse.de>
To: Aviv Greenberg <avivg@voltaire.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: softirq question
Message-ID: <20010523113914.A16732@gruyere.muc.suse.de>
In-Reply-To: <20083A3BAEF9D211BDB600805F8B14F3AE37D7@NTSERVER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20083A3BAEF9D211BDB600805F8B14F3AE37D7@NTSERVER>; from avivg@voltaire.com on Wed, May 23, 2001 at 12:26:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 12:26:49PM +0200, Aviv Greenberg wrote:
> Hi,
> 
> Is it possible to enter into sleep mode 
> ( current->state = !RUNNING && schedule(_timeout))
> from a softirq ?

No.

> 
> It is not a real hardware interrupt after all, but it still runs in
> the context of a running process....

It is for all practical purposes like an interrupt and can run in any 
process context.


-Andi
