Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUDVUnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUDVUnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUDVUnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:43:09 -0400
Received: from mail-haw.bigfish.com ([12.129.199.61]:7648 "EHLO
	mail43-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S264664AbUDVUnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:43:03 -0400
Message-ID: <40882E49.2040705@lehman.com>
Date: Thu, 22 Apr 2004 16:42:49 -0400
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Len Brown" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z
 aka Newisys 2100
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
 <1082653547.16336.335.camel@dhcppc4> <408820D7.10400@lehman.com>
 <1082666116.16336.391.camel@dhcppc4>
In-Reply-To: <1082666116.16336.391.camel@dhcppc4>
X-WSS-ID: 6C96F1C0208552-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Intel MultiProcessor Specification v1.4
>>    Virtual Wire compatibility mode.
>>SMP mptable: bad signature [<3>BIOS bug, MP table errors detected!...
>>... disabling SMP support. (tell your hw vendor)
>>    
>>
>
>Broken BIOS/MPS tables own this failure.
>See if you can disable MPS in the BIOS/SETUP.
>that is, after you verify you've got the latest BIOS...
>  
>

But that still does not explain why RedHat AS3 works on the same machine 
with the same BIOS settings without specifying any acpi related 
parameters.  As far as I can tell, AS3 is using an older version of the 
ACPI code.  It reports "ACPI: Subsystem revision 20030619" when 
booting.  So barring some hack RedHat has in there,  clearly something 
has changed along the way to break things on this machine...

Thanks,
Shantanu



------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the
designated recipient(s) named above.  If you are not the intended recipient of
this message you are hereby notified that any review, dissemination,
distribution or copying of this message is strictly prohibited.  This
communication is for information purposes only and should not be regarded as
an offer to sell or as a solicitation of an offer to buy any financial
product, an official confirmation of any transaction, or as an official
statement of Lehman Brothers.  Email transmission cannot be guaranteed to be
secure or error-free.  Therefore, we do not represent that this information is
complete or accurate and it should not be relied upon as such.  All
information is subject to change without notice.

