Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUDVVBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUDVVBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbUDVVBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:01:52 -0400
Received: from fmr01.intel.com ([192.55.52.18]:8876 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264668AbUDVVBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:01:50 -0400
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z aka
	Newisys 2100
From: Len Brown <len.brown@intel.com>
To: Shantanu Goel <Shantanu.Goel@lehman.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40882E49.2040705@lehman.com>
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
	 <1082653547.16336.335.camel@dhcppc4> <408820D7.10400@lehman.com>
	 <1082666116.16336.391.camel@dhcppc4>  <40882E49.2040705@lehman.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082667692.16337.400.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 17:01:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 16:42, Shantanu Goel wrote:
> >>Intel MultiProcessor Specification v1.4
> >>    Virtual Wire compatibility mode.
> >>SMP mptable: bad signature [<3>BIOS bug, MP table errors detected!...
> >>... disabling SMP support. (tell your hw vendor)
> >>    
> >>
> >
> >Broken BIOS/MPS tables own this failure.
> >See if you can disable MPS in the BIOS/SETUP.
> >that is, after you verify you've got the latest BIOS...
> >  
> >
> 
> But that still does not explain why RedHat AS3 works on the same machine 
> with the same BIOS settings without specifying any acpi related 
> parameters.  As far as I can tell, AS3 is using an older version of the 
> ACPI code.  It reports "ACPI: Subsystem revision 20030619" when 
> booting.  So barring some hack RedHat has in there,  clearly something 
> has changed along the way to break things on this machine...

Right, the broken BIOS does not explain that failure.

Perhaps you can enumerate what kernels do boot on this box.
If there is RH special sauce at work, then I'd expect that
none of the kernel.org 2.4 kernels boot either.

-Len


