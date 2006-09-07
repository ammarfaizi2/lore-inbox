Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWIGOJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWIGOJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWIGOJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:09:10 -0400
Received: from relay03.pair.com ([209.68.5.17]:29203 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S964826AbWIGOJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:09:09 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 09:01:23 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Stuart MacDonald <stuartm@connecttech.com>
cc: "'Chase Venters'" <chase.venters@clientec.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, ellis@spinics.net,
       "'Willy Tarreau'" <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [OT] RE: bogofilter ate 3/5
In-Reply-To: <086c01c6d285$a7ae9e40$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.64.0609070857310.31500@turbotaz.ourhouse>
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

Fortunately, the bulk of bulk mail I receive these days is forged but not 
forged from legitimate users. To give you an example from my daily log 
(which is e-mailed to me so I can keep an eye on the insanity):

2006-09-06T06:25:11 -- Challenged 'Beliefnet Daily Inspiration 
<BeliefnetDailyInspiration@partner.beliefnet.com>'
2006-09-06T06:40:23 -- Challenged '"newsletters@frommers.com" 
<newsletters@frommers.com>'
2006-09-06T09:56:13 -- Challenged '"LexingtonLawBringsYou" 
<LexingtonLawBringsYou@deadchristmastree.net>'
2006-09-06T12:25:34 -- Challenged '"OFFER  CONFIRMATION." 
<slt@protective-vehicle.com>'
2006-09-06T12:30:39 -- Challenged '"Rate Alert!" 
<LocalRate@requiredinstallation.com>'
2006-09-06T12:57:54 -- Challenged '"Rate Alert!" 
<LocalRate@wonderful-scholar.com>'
2006-09-06T12:57:56 -- Challenged '"OFFER  CONFIRMATION." 
<slt@related-polymer.com>'
2006-09-06T13:08:02 -- Challenged '"PlatinumRewardsClubEmailOffers" 
<PlatinumRewardsClubEmailOffers@solitarygroup.com>'
2006-09-06T13:34:18 -- Challenged '"CellPhoneGiveawaysNetDeals" 
<CellPhoneGiveawaysNetDeals@hillbillymaryann.com>'
2006-09-06T13:39:23 -- Challenged '"Barber" <lpb@coveredrevenue.com>'
2006-09-06T13:59:36 -- Challenged '"Barber" <lpb@coveredrevenue.com>'
2006-09-06T14:08:44 -- Challenged '"LifeScript Healthy Advantage" 
<LifeScriptHealthyAdvantage@lifescript.com>'
2006-09-06T14:27:00 -- Challenged 'FS Report <freeinkplus@reply.mb00.net>'
2006-09-06T14:46:12 -- Challenged '"OFFER_C0NFIRMATI0N!" 
<ndc@differentirradiation.com>'
2006-09-06T15:07:26 -- Challenged '"Maureen&Team" <maureen@sdejwire.com>'
2006-09-06T15:07:27 -- Delivered message from 'Sune Kloppenborg Jeppesen 
<jaervosz@gentoo.org>' (whitelist)
2006-09-06T15:09:30 -- Challenged '"BHG.com 
Kitchen"<Recipe@email.bhg.com>'
2006-09-06T15:11:40 -- Challenged '"1 2 3  I n k Jets" 
<ikj@subsequent-grievance.com>'

If these challenges bounce (_many_ of them do), the box and host end up on 
the blacklist.

> ..Stu
>
>

Thanks,
Chase
