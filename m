Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291729AbSBTK3F>; Wed, 20 Feb 2002 05:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291727AbSBTK2z>; Wed, 20 Feb 2002 05:28:55 -0500
Received: from [195.63.194.11] ([195.63.194.11]:47110 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291720AbSBTK2o>; Wed, 20 Feb 2002 05:28:44 -0500
Message-ID: <3C737A2C.2060305@evision-ventures.com>
Date: Wed, 20 Feb 2002 11:27:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: trivial@rustcorp.com.au, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tiny IDE cleanup
In-Reply-To: <20020219194155.GA5468@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> What about this tiny cleanup? Its against 2.4., but applicable to 2.5,
> too.
> 

That's file.

If you dare to have a look at the LOCAL_END_REQUEST macro
as well? It's only used by IDE and NBD code.
I think that from IDE it can be just deleted. But I didn't
look at NBD.

