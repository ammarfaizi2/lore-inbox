Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRKINj6>; Fri, 9 Nov 2001 08:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRKINjp>; Fri, 9 Nov 2001 08:39:45 -0500
Received: from ns.suse.de ([213.95.15.193]:14 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279805AbRKINjb>;
	Fri, 9 Nov 2001 08:39:31 -0500
Date: Fri, 9 Nov 2001 14:39:30 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109143930.C30575@wotan.suse.de>
In-Reply-To: <E162BFV-0002y1-00@the-village.bc.nu> <20011109.045455.74749430.davem@redhat.com> <20011109141755.A30575@wotan.suse.de> <20011109.052554.41631501.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011109.052554.41631501.davem@redhat.com>; from davem@redhat.com on Fri, Nov 09, 2001 at 05:25:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 05:25:54AM -0800, David S. Miller wrote:
> Why in the world do we need indirection function call pointers
> in TCP to handle that?

To handle the case of not having a separate TIME-WAIT table
(sorry for being unclear). Or alternatively several conditionals. 

-Andi

