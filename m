Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316327AbSEQQYu>; Fri, 17 May 2002 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316330AbSEQQYt>; Fri, 17 May 2002 12:24:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:40458 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316327AbSEQQYs>; Fri, 17 May 2002 12:24:48 -0400
Date: Fri, 17 May 2002 20:24:03 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, andrew.grover@intel.com,
        mochel@osdl.org, Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020517202403.A28687@jurassic.park.msu.ru>
In-Reply-To: <3CE512A7.70202@mandrakesoft.com> <20020517.071633.67125480.davem@redhat.com> <3CE514B6.6070302@mandrakesoft.com> <20020517.072625.29433758.davem@redhat.com> <3CE516E4.4000500@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 10:42:44AM -0400, Jeff Garzik wrote:
> Makes sense, sure :)  I just want to get rid of the untyped sysdata in 
> favor of a struct with a defined type (arch-defined... but named and 
> defined nonetheless).

Just to be sure, do you mean both struct pci_bus and struct pci_dev? :-)
On alpha both sysdata's are pointers to the same thing, but not on sparc
as far as I can see.

Ivan.
