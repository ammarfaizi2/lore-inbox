Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVJDNNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVJDNNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVJDNNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:13:51 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:14598 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932443AbVJDNNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:13:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051004125354.GO10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net> <20051003015302.GP6290@lkcl.net> <20051003181924.GB8011@csclub.uwaterloo.ca> <20051004125354.GO10538@lkcl.net>
X-OriginalArrivalTime: 04 Oct 2005 13:13:48.0300 (UTC) FILETIME=[74D354C0:01C5C8E5]
Content-class: urn:content-classes:message
Subject: Re: what's next for the linux kernel?
Date: Tue, 4 Oct 2005 09:13:47 -0400
Message-ID: <Pine.LNX.4.61.0510040912460.28122@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what's next for the linux kernel?
Thread-Index: AcXI5XTc2CYK17saRfW9nCNQ0CImQQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>
Cc: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       "Vadim Lobanov" <vlobanov@speakeasy.net>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Luke Kenneth Casson Leighton wrote:

>> Hmm, so if we guess it might take 10 masks per processor type over it's
>> life time as they change features and such, that's still less than 1% of
>> the cost of the FAB in the first place.  I agree with the person that
>> said intel/AMD/company probably don't care much, as long as their
>> engineers make really darn sure that the mask is correct when they go to
>> make one.
>
> you elaborate, therefore, on my point.
>
> anyone else, therefore, cannot hope to compete or even enter the
> market, at 90nm.
>
> which is why the first VIA eden processors maxed out at 800mhz (i'm
> guessing they were a 0.13micron and therefore 2.5 volts)
>
>>>  ... why do you think intel is hyping support for and backing
>>>  hyperthreads support in XEN/Linux so much?
>>
>> Ehm, because intel has it and their P4 desperately needs help to gain
>> any performance it can until they get the Pentium-M based desktop chips
>> finished with multiple cores, and of course because AMD doesn't have it.
>> Seem like good reasons for intel to try and push it.
>
> you lend weight to my earlier points: the push is to
> drive the engineers towards less gates on the excuse of
> cart-before-horsing the market with their "performance / watt"
> metrics, such that if 0.65nm comes off it's less painful
> and not too much of a jump, and they aim for more parallel
> processing (multiple cores).
>
> current  : 200 million gates with 90nm at 1.65 volt
> estimated: 40 million gates with 65nm at 1.1 volt
> estimated: 1 million gates with 45nm at 0.9 volt.
>
> the "off" voltage of a silicon germanium transistor is 0.8 volts.
>
> at 45nm the current leakage is so insane that the heat
> dissipation, through the oxide layer which covers the chip,
> ends up blowing the chip up.
>
> trouble.
>
> l.

Since the voltage goes down as the speed increases, an
industry joke has been that at 0 volts you can get the
speed that you want. Unfortunately, the required infinite
current is a bit hard to manage. This brings up the
configuration change that has been in the works for
some time, current-mode logic. Just like TTL gave way
to ECL to obtain two orders of magnitude increase in
random-logic speed, there will be a similar increase once
current rather than voltage is used for logic levels.
And, it's not absolute current, either but delta-current
which will define a logic state.

The problems with reducing capacity end up being exacerbated
when logic states are stored in the very capacity that is
being reduced. Eventually there is little difference between
"logic" and "noise". This brings up the new science of
"statistical logic" which has yet to make its way into
microprocessors, but soon will once the quantization noise
becomes a factor.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
