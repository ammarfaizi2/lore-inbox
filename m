Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313715AbSDPPqT>; Tue, 16 Apr 2002 11:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313716AbSDPPqS>; Tue, 16 Apr 2002 11:46:18 -0400
Received: from jalon.able.es ([212.97.163.2]:9384 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313715AbSDPPqR>;
	Tue, 16 Apr 2002 11:46:17 -0400
Date: Tue, 16 Apr 2002 17:46:08 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        wli@holomorphy.com
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416154608.GA2694@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.44L.0204161156330.1960-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.16 Rik van Riel wrote:
>On Tue, 16 Apr 2002, Oliver Xymoron wrote:
>> On Mon, 15 Apr 2002, Linus Torvalds wrote:
>> > On Mon, 15 Apr 2002, Linus Torvalds wrote:
>> > >
>> > > Which requires the user to use something like
>> > >
>> > > 	for_each_zone(zone) {
>> > > 		...
>> > > 	} end_zone;
>
>> Ugh. If we're going to use such ugly things, it would be nice if they were
>> do_zone/while_zone instead of being suggestive of a for loop.
>
>Ummm, it _is_ a for loop.
>

Perhaps a silly change like

for_all_zone -> forall_zone
for_all_page -> forall_page

changes the point of view of some people. Some languages implement a 'forall'
iteration. And looks better...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam2 #2 SMP Tue Apr 16 00:29:36 CEST 2002 i686
