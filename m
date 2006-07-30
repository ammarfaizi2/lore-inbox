Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWG3Kah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWG3Kah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWG3Kah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:30:37 -0400
Received: from abfb156.neoplus.adsl.tpnet.pl ([83.7.39.156]:54661 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S932238AbWG3Kag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:30:36 -0400
Date: Sun, 30 Jul 2006 12:30:10 +0200
To: "Hans Reiser" <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
From: =?iso-8859-2?B?o3VrYXN6IE1pZXJ6d2E=?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com> <44CABB87.3050509@namesys.com> <1154164364.2903.10.camel@laptopd505.fenrus.org> <44CBA4BF.80301@slaphack.com> <1986618636.20060730024539@wp.pl> <44CC06A7.1030104@namesys.com>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdhzgkjqd4os1z@localhost>
In-Reply-To: <44CC06A7.1030104@namesys.com>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-15.078, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.72, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Sun, 30 Jul 2006 03:08:55 +0200, Hans Reiser <reiser@namesys.com>  
napisa³:

> Maciej So³tysiak wrote:
>
>>
>> Hmm, what about linspire / freespire ? Linsire is a proud reiser4  
>> debugging
>> sponsor as the website (http://www.namesys.com) says.
>>
>> Wouldn't they want to include reiser4 in their distro first?
>>
>>
>>
> Not if the mainstream kernel is not going to add it.....

If I got it all rigth then the VFS issue is there from the moment when  
Hans made a request to merge reiser4 into mainstream, nobody nows what  
will happen tomorrow, it will go in without moving things to vfs, it can  
go in with moving some code to vfs or it can stay forever outside. If it's  
not sure then no distro will use it as a main fs (or at all) becouse if  
tommarow Hans will say "Ok, will move things to VFS" then for the next  
year or so reiser4 will be simply dead, it will take a lot of time to  
recode it and this change will provide a lot of bugs that will need to be  
debuged, it won't a be a single patch anymore as You will need to patch  
that adds reiser4 and a patch that alters VFS. What distro would toy with  
VFS? None until it's all done, fully and trully tested and merged into  
mainline, it won't happen quickly and it is not said that there won't be  
any more complains when this is done.
In my opinion there is no best option for reiser4 only less evil ways,  
it's just too different from other fs, too independent.
Again I'm no expert, just enduser.

