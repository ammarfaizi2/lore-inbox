Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbULBFLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbULBFLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 00:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbULBFLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 00:11:53 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:51868 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S261557AbULBFLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 00:11:19 -0500
Message-ID: <41AEA3F0.9080100@bigpond.net.au>
Date: Thu, 02 Dec 2004 16:11:12 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <E1CZiZZ-0005ew-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1CZiZZ-0005ew-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org> you wrote:
> 
>>I think you're making that up. Maybe there's some sw cult that swears by 
>>"contract programming"
> 
> 
> Design by Contract is the reason for descibing the agreement between
> caller/callee as an contract.

Design by contract isn't really an agreement between the caller and the 
callee (which may not even exist when the contract is created).  It's 
more of a (one way) promise by the callee that if the interface is used 
as described in the contract that it will correctly perform the 
advertised operation (where the advertised operation generally includes 
descriptions of possible failures and how they will be signalled).  Most 
C APIs meet these criteria even though their pre and post conditions are 
expressed less formally than an Eiffel interface.

> Bertran Meyer added the pre-conditions and
> post-conditions (kind of asserts) to his Eiffel Language, and I dont think
> that that is limited to a single system, but is also valid for bondaries
> like an ABI. It describes conventions like syscall numbers, too.

I agree but think it's important to realize that it's a unilateral 
promise on the part of the callee (rather than agreement between the 
callee and the caller) which is in accord with Linus's view of the ABI.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
