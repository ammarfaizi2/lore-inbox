Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310491AbSCLJJT>; Tue, 12 Mar 2002 04:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310501AbSCLJJF>; Tue, 12 Mar 2002 04:09:05 -0500
Received: from ns.suse.de ([213.95.15.193]:53252 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310494AbSCLJId>;
	Tue, 12 Mar 2002 04:08:33 -0500
Date: Tue, 12 Mar 2002 10:07:24 +0100
From: Andi Kleen <ak@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: zero copy.
Message-ID: <20020312100724.A11914@wotan.suse.de>
In-Reply-To: <200203120859.JAA04099@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203120859.JAA04099@cave.bitwizard.nl>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 09:59:36AM +0100, Rogier Wolff wrote:
> 
> Hi,
> 
> Is linux able to do zero copy?

You can do zero copy on TX by using sendfile() or writing a kernel module. 
Zero copy on RX is not directly supported by the standard network stack.
It's possible to do it via a kernel module again, but very hackish. 

-Andi

