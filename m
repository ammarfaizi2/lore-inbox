Return-Path: <linux-kernel-owner+w=401wt.eu-S1754906AbXABSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbXABSoF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbXABSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:44:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:53852 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbXABSoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:44:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f5unp2Eu5i/EYTrVvn7mMbqlS55Kgsx/ukO8OawwayyMWn/fwq1Rp2Q0CWWYiriguAFSG/xD1S107Sfc+gfqGKxTrgeI6UvTx4YBUXV9yPXAy8JCdCnkyUOsQB+2ZHmge3QH8Qi/mEjcLcGZEjExmOEv7AkggkWBWMkM+FEjKMQ=
Message-ID: <459AA7EE.2090202@gmail.com>
Date: Tue, 02 Jan 2007 13:43:58 -0500
From: Richard Smith <smithbone@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: David Kahn <dmk@flex.com>, David Miller <davem@davemloft.net>,
       devel@laptop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <20061230.211941.74748799.davem@davemloft.net>	<459784AD.1010308@firmworks.com>	<45978CE9.7090700@flex.com>	<20061231.024917.59652177.davem@davemloft.net>	<4597A4A2.9060304@flex.com> <1167710167.6165.21.camel@localhost.localdomain>
In-Reply-To: <1167710167.6165.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>> This is a trivial implementation that suits it's purpose.
>> It's simple. I'm not sure what more is needed for this
>> project when it's pretty clear that i386 will never need
>> any additional support for open firmware.
> 
> I don't agree. It's definitely not clear to me.... Especially as open

If Linuxbios has its way then this is indeed not true.  We are in the 
middle of our design for V3 and the hardware representation will be 
based on a device-tree description.  From that we plan to auto generate 
the various tables that i386 stuff uses.  But ideally the kernel could 
get all it needed from the device-tree.

At least 1 major manufacturer is interested in providing LinuxBios on 
some of its motherboards and AMD supports LinuxBios so in the near 
future x86 should have a real reason to have full device-tree support.

--
Richard A. Smith.

