Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVAKEnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVAKEnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVAKEkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:40:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:56334 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262384AbVAKEjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:39:52 -0500
Date: 11 Jan 2005 05:39:49 +0100
Date: Tue, 11 Jan 2005 05:39:49 +0100
From: Andi Kleen <ak@muc.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Yinghai Lu <yhlu@tyan.com>, "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       jamesclv@us.ibm.com, Matt_Domsch@dell.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: 256 apic id for amd64
Message-ID: <20050111043949.GB73523@muc.de>
References: <20050110184437.GA74665@muc.de> <20050110200425.B30630@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110200425.B30630@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 08:04:25PM -0800, Siddha, Suresh B wrote:
> Andi, we don't need physical APIC mode just to handle CPU APIC ID's > 7
> when the total number of cpu's in the system is < 8. Right?

Yes, cutoff point is 8, not 7, agreed. 

-Andi

