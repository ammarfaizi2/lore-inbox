Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVHIUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVHIUUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVHIUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:20:40 -0400
Received: from smtpout.mac.com ([17.250.248.85]:30715 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964928AbVHIUUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:20:39 -0400
In-Reply-To: <1123600593.7622.116.camel@localhost.localdomain>
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr> <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU> <20050809015048.GA14204@thunk.org> <Pine.LNX.4.63.0508090044400.20178@excalibur.intercode> <1123600593.7622.116.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BA6F2E8F-C63B-4461-85F8-37E5B0EFAD33@mac.com>
Cc: James Morris <jmorris@namei.org>, "Theodore Ts'o" <tytso@mit.edu>,
       David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: understanding Linux capabilities brokenness
Date: Tue, 9 Aug 2005 16:20:20 -0400
To: Christopher Warner <cwarner@kernelcode.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 9, 2005, at 11:16:33, Christopher Warner wrote:
> In my observer pragmatic view; yes. On many occasion, i've come to CAP
> calls only to be frustrated with the sheer disconnect of it all. It
> simply doesn't work. If it means having to break posix conformance  
> for a
> working implementation. Then so be it.
>
> On Tue, 2005-08-09 at 00:46 -0400, James Morris wrote:
>
>> Let me play the Devil's advocate here.
>>
>> Should we be thinking about deprecating and removing capabilities  
>> from
>> Linux?

One brief suggestion:

A key/token interface was recently introduced that might be useful to  
allow
a simple new inheritance model for "capabilities", "roles",  
"rootperms" or
whatever other abstraction you create.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare


