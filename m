Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSDSTyo>; Fri, 19 Apr 2002 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSDSTyn>; Fri, 19 Apr 2002 15:54:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2130 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312453AbSDSTym>; Fri, 19 Apr 2002 15:54:42 -0400
To: Nick Martens <nickm@kabelfoon.nl>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Boot problem
In-Reply-To: <3CB1B505.2010505@kabelfoon.nl>
	<200204100517.g3A5HhX04634@Port.imtp.ilyichevsk.odessa.ua>
	<3CB5F98C.7010206@kabelfoon.nl>
	<200204121056.g3CAuQX13845@Port.imtp.ilyichevsk.odessa.ua>
	<3CBDB4E2.3050406@kabelfoon.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Apr 2002 13:47:21 -0600
Message-ID: <m1r8lb4gja.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Martens <nickm@kabelfoon.nl> writes:

> Sorry for the long time without responding but I haven't had any time lately
> I'm not sure how to solve it yet I don't know about that ECC mem problem but are
> 
> there any other devices for which this is typical behaviour or even some BIOS
> setting which may cause this
> 
> 
> 
> Denis Vlasenko wrote:
> > On 11 April 2002 19:01, Nick Martens wrote:
> >
> >>I've tried to do the break thing and then boot after 2 minutes, but the
> >>problem remains. Is it passible that due to the HW-reset some device
> >>gets resetted too and works fine afterwards ???
> > Yes, I can imagine some hw which needs to be warm to operate properly.
> > It may be unable to reset/init in cold state.
> > Is it true that some types of (ECC?) memory need several read passes over them
> 
> > to initialize?

ECC memory must be written to ensure the ECC bits are in a consistent
state but that should just take a second or two.

Eric
