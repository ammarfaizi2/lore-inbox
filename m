Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWIGOfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWIGOfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWIGOfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:35:05 -0400
Received: from relay03.pair.com ([209.68.5.17]:64273 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751778AbWIGOfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:35:02 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 09:27:11 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Stuart MacDonald <stuartm@connecttech.com>
cc: "'Chase Venters'" <chase.venters@clientec.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, ellis@spinics.net,
       "'Willy Tarreau'" <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: RE: bogofilter ate 3/5
In-Reply-To: <086c01c6d285$a7ae9e40$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.64.0609070915580.31500@turbotaz.ourhouse>
References: <086c01c6d285$a7ae9e40$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Stuart MacDonald wrote:

> From: On Behalf Of Chase Venters
>> You can check the From: or envelope sender against the subscriber
>> database. Forgery isn't a concern because we're not trying to stop
>> forgery with this method. Subscribers subscribing one address
>
> Forgery is always a concern...
>
>> The perl script behaves as an optional autoresponder.
>> Autoresponders would
>> respond to spam as well (well, unless you put a spam filter
>> in front of
>> them, but I assume that many don't).
>
> ..because autoresponders are always replying to forged addresses:
> http://www.spamcop.net/fom-serve/cache/329.html
>
>> Also note that a number of people (myself included, at work
>> anyway) have
>> perl scripts that respond to all incoming mail and require a
>> reply cookie from original
>> envelope senders. We do it because it almost entirely
>> prevents spam from
>> arriving in our inboxes (I say almost because there is the occasional
>
> Autoresponder by another name, see above URL.

I should also point out that common and regular mailing list software 
already often behaves as an autoresponder, and it is completely 
reasonable! Suppose that you send a message to a mailing list that is 
subscriber-only. What usually happens? You get mail back saying that your 
message has been queued for moderator review!

Naturally, such a system suffers from the same problems described by 
the Spamcop page you linked. But it is unreasonable to ask list managers 
not to respond to unknown traffic, because sending a message to a list and 
having it silently disappear is unacceptable.

Now, I'm sure there are some people that don't run mailing lists that 
would love to call this behavior 'bad'. But there are also people who 
would like to rewrite the rules for Internet mail (see: SPF and the 
problem with mail forwarders, and their so-called 'solution'). Since 
Internet mail was designed in a vacuum where these modern problems don't 
exist, we're all forced to work around them in unusual ways. I find it 
highly ironic that spam blocker services tell you not to use certain 
techniques (autoresponders, bounce messages) that are not only 
commonplace, but precedented and even mandated by RFC on the grounds that 
they may cause you to be blocked. Then they move on to criticize anti-spam 
techniques that fall in these domains with one of their subpoints saying 
'they can cause you to miss legitimate mail!'

Guess what: so does indiscriminately blocking people whose sites don't bow 
down to your unreasonable demands, especially when their behavior (say, 
sending bounce messages) is described in the official protocol 
documentation.

Taking away auto-responders is like taking away hair gel from airline 
passengers: a gross overreaction that diminishes the quality of service 
for everyone.

> ..Stu
>

Thanks,
Chase
