Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSLCWx2>; Tue, 3 Dec 2002 17:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSLCWx2>; Tue, 3 Dec 2002 17:53:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44076 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266368AbSLCWx2>; Tue, 3 Dec 2002 17:53:28 -0500
Date: Tue, 3 Dec 2002 18:00:52 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] ACPI updates
Message-ID: <20021203180052.B7885@devserv.devel.redhat.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A56B@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A56B@orsmsx119.jf.intel.com>; from andrew.grover@intel.com on Tue, Dec 03, 2002 at 10:39:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 10:39:18AM -0800, Grover, Andrew wrote:

> The ACPI code's CPU-enumeration-only config option does what acpitable.[ch]
> did. 

With a lot more code.

> Is your concern with the code, or the cmdline option? We could certainly

the code, not so much the commandline option (that one is not used
in practice), but actually my biggest concern is that you break existing
setups, or at least change it more than needed. There is ZERO need to
remove the existing working (and lean) code, even though your code might
also be able to do the same. It means people suddenly need to change all
kinds of config options, it's different code so will work slightly
different... unifying 2.5 is nice and all but there's no need for that
here since both implementations can coexist trivially (as the United Linux
kernel shows)

Greetings,
   Arjan van de Ven
