Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310606AbSCMOKq>; Wed, 13 Mar 2002 09:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310607AbSCMOKf>; Wed, 13 Mar 2002 09:10:35 -0500
Received: from ns.suse.de ([213.95.15.193]:46087 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310606AbSCMOKZ>;
	Wed, 13 Mar 2002 09:10:25 -0500
Date: Wed, 13 Mar 2002 15:10:24 +0100
From: Dave Jones <davej@suse.de>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC -- lockup on machine if enabled
Message-ID: <20020313151024.G7658@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Josh Fryman <fryman@cc.gatech.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313083422.3262cb35.fryman@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020313083422.3262cb35.fryman@cc.gatech.edu>; from fryman@cc.gatech.edu on Wed, Mar 13, 2002 at 08:34:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 08:34:22AM -0500, Josh Fryman wrote:
 > i have a new laptop (Dell Latitude C610) running 2.4.18-rc4.  when i built the
 > new kernel, i thought i would amuse myself by turning on IO-APIC.

 Known problem.

 > any suggestions?

 "Don't do that"  8-)
 2.5 (and possibly 2.4-ac) has the early-dmi code which disables this
 option if it detects its running on a Dell laptop.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
