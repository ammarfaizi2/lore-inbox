Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbUJ0UGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUJ0UGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUJ0T7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:59:44 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20122 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262570AbUJ0T7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:59:01 -0400
Message-ID: <417FFE82.4060305@tmr.com>
Date: Wed, 27 Oct 2004 16:01:06 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Augustijn <kernel@janestarz.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase
References: <9550.212.241.49.39.1098883651.squirrel@webmail.xs4all.nl>
In-Reply-To: <9550.212.241.49.39.1098883651.squirrel@webmail.xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Augustijn wrote:
> On Tue, Oct 26, 2004 at 08:17:53AM +0200, Jan Engelhardt wrote:
> 
>>>This here patch will make the kernel use a default passphrase (compiled
> 
> into
> 
>>>the kernel or cryptoloop.ko module) when you set up a cryptoloop device
> 
> with:
> 
>>Suppose I break in via ssh:
>>I could load the module (if applicable), and find the address of the
>>function or variable in System.map, extract the static passphrase, and
>>well. Then?
> 
> 
> Ahem.
> The point you are making is rather moot. Because if you manage to get a
> shell on the system, the data can readily be copied because the encrypted
> filesystem is supposed to be mounted.
> Unless I miss your point.
> 
> And once you are in the system there are easier ways to obtain the
> passphrase than the one you described above. As I clearly stated earlier,
> it is merely more difficult to obtain the encrypted data. It is _not_
> impossible. It took me approximately 4 hours to break into the system
> myself. I bet there's people around who can do it in less than 1 hour.
> 
> Some of you might then ask: "What's the point of it then anyway?"
> Well, I am probably capable of creating a much better solution with almost
> unbreakable encryption. My boss just won't allow me the time for this.
> This patch took me about a day to write. It's the best I could come up
> with in such a short time.

And this provides another level of protection, which makes it useful. It 
stops the casual thief who steals your laptop, and that's the most 
likely exposure. If you expect you system to be secure against 
government agencies or serious industrial espionage, this is pretty much 
worthless, better crypto would be needed, encrypted swap, etc.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
