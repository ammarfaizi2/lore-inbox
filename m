Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTFLQIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTFLQIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:08:47 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:32195 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264873AbTFLQIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:08:45 -0400
Message-ID: <3EE8AB18.2060109@free.fr>
Date: Thu, 12 Jun 2003 18:32:24 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
References: <3EE66C86.8090708@free.fr>	<20030611211506.GD16164@fs.tum.de> <20030612160552.770bd15e.skraw@ithnet.com>
In-Reply-To: <20030612160552.770bd15e.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Wed, 11 Jun 2003 23:15:06 +0200
> Adrian Bunk <bunk@fs.tum.de> wrote:
> 
> 
>>[...]
>>The important thing is that this is inside a stable kernel series and an 
>>update that makes things better for 100 people but makes things worse 
>>for one person is IMHO bad since it's a regression for one person.
> 
> 
> You cannot fulfill that in reality. Looking at the broad variety of software
> out there you simply cannot know all the implications a simple bug fix may
> have. There may well be boxes that rely on a broken code you just fixed. Only
> god knows. So you sometimes simply have to do "the right thing"(tm) knowing
> there will always be people who shoot you for it.


Just to go a little bit more in that direction, I already have seen an 
obvious one-line patch that caused a deadlock in another OS because due 
to code location change and probably an additionnal cache miss on 
specific part of the code, an existing synchronisation bug that was 
never triggered started to effectively happen...

Besides, if you please 1000 users and cause problem to 2 of them because 
they have broken hardware, I think you are going into the right direction.

 >The important sections are more likely (ordered by priority):
 > - bug fixes (e.g. aic7xxx)
 > - support for additional hardware (e.g. ACPI update)
 > - new features (e.g. XFS)


Bug fixes are meant to make the 2.4 kernel more useable right? So I do 
not reallly see the utimate difference with other things in your 
category. What I was asking is a rationnal way of chosing the 
priorities. You gave me yours without real explanation.

The purpose of the original mail was to ask for discussion/clarification 
on 2.4 development priorities (e.g something like the 2.6 todo list) and 
a proposal to set up the priorities using generic targetted hardware 
(server, laptop, desktop) as hint for requirement selection.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

