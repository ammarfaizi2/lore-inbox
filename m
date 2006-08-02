Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWHBTIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHBTIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHBTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:08:04 -0400
Received: from abfd146.neoplus.adsl.tpnet.pl ([83.7.41.146]:44507 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S932131AbWHBTID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:08:03 -0400
Date: Wed, 02 Aug 2006 19:07:39 +0200
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
From: =?utf-8?B?xYF1a2FzeiBNaWVyendh?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <200608021845.k72Ij7us009749@laptop13.inf.utfsm.cl>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdn1u1c27okmjo@localhost>
In-Reply-To: <200608021845.k72Ij7us009749@laptop13.inf.utfsm.cl>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-15.315, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.49, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wed, 02 Aug 2006 20:45:07 +0200, Horst H. von Brand  
<vonbrand@inf.utfsm.cl> napisał:

> Vladimir V. Saveliev <vs@namesys.com> wrote:
>> On Tue, 2006-08-01 at 17:32 +0200, Å�ukasz Mierzwa wrote:
>> > Dnia Fri, 28 Jul 2006 18:33:56 +0200, Linus Torvalds  
>> <torvalds@osdl.org>
>> > napisaÅ‚:
>> > > In other words, if a filesystem wants to do something fancy, it  
>> needs to
>> > > do so WITH THE VFS LAYER, not as some plugin architecture of its  
>> own. We
>> > > already have exactly the plugin interface we need, and it literally  
>> _is_
>> > > the VFS interfaces - you can plug in your own filesystems with
>> > > "register_filesystem()", which in turn indirectly allows you to  
>> plug in
>> > > your per-file and per-directory operations for things like lookup  
>> etc.
>
>> > What fancy (beside cryptocompress) does reiser4 do now?
>>
>> it is supposed to provide an ability to easy modify filesystem behaviour
>> in various aspects without breaking compatibility.
>
> If it just modifies /behaviour/ it can't really do much. And what can be
> done here is more the job of the scheduler, not of the filesystem. Keep  
> your
> hands off it!

You modify the way the fs stores files or let You access them, since when  
it is a job for a scheduler?

> If it somehow modifies /on disk format/, it (by *definition*) isn't
> compatible. Ditto.
>
>> > Can someone point me to a list of things that are required by kernel
>> > mainteiners to merge reiser4 into vanilla?
>>
>> list of features reiser4 does not have now:
>> O_DIRECT support - we are working on it now
>> various block size support
>
> Is this required?
>
>> quota support
>> xattrs and acls
>
> Without those, it is next to useless anyway.

I don't use any of this and I live quite happly.


