Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbTLaSU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbTLaSU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:20:57 -0500
Received: from rs9.luxsci.com ([66.216.98.59]:61671 "EHLO rs9.luxsci.com")
	by vger.kernel.org with ESMTP id S265216AbTLaSU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:20:56 -0500
Message-ID: <3FF31366.30206@acm.org>
Date: Wed, 31 Dec 2003 10:20:22 -0800
From: Javier Fernandez-Ivern <ivern@acm.org>
Reply-To: ivern@acm.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rudi@lambda-computing.de
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de>
In-Reply-To: <3FF2FC85.5070906@lambda-computing.de>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rüdiger Klaehn wrote:

> I have been wondering for some time why there is no decent file change 
> notification mechanism in linux. Is there some deep philosophical reason 
> for this, or is it just that nobody has found the time to implement it? 
> If it is the latter, I am willing to implement it as long there is a 
> chance to get this accepted into the mainstream kernel.

Well, there's fam.  But AFAIK that's all done in user space, and your 
approach would be significantly more efficient (as a matter of fact, fam 
could be modified to use your change device as a first level of 
notification.)

I'll be interested in testing this, or (if you wish) help get it done. 
I'm a kernel hacking newbie at the moment, but I have tinkered around 
enough with the VFS to be able to work on this.  Up to you.

-- 
Javier Fernandez-Ivern
