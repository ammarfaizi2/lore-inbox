Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWJ2SYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWJ2SYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWJ2SYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:24:23 -0500
Received: from main.gmane.org ([80.91.229.2]:13490 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932367AbWJ2SYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:24:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: why test for "__GNUC__"?
Date: Sun, 29 Oct 2006 18:23:40 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek9sq2.2vm.olecom@flower.upol.cz>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain> <20061029120534.GA4906@martell.zuzino.mipt.ru> <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain> <slrnek9le5.2vm.olecom@flower.upol.cz> <20061029171855.GF27968@stusta.de> <Pine.LNX.4.64.0610291223520.31583@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>, Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-29, Robert P. J. Day <rpjday@mindspring.com> wrote:
> On Sun, 29 Oct 2006, Adrian Bunk wrote:
>
>> On Sun, Oct 29, 2006 at 04:17:51PM +0000, Oleg Verych wrote:
>> >...
>> > On 2006-10-29, Robert P. J. Day wrote:
>> >>...
>> > And if you can, please, help with development or bugs, not this.
>>
> Cleanup of the kernel source is also a valuable task (and as a side
> effect it even sometimes finds bugs).

Accept, Adrian, not in this case (;.

> in any event, i'm most emphatically *not* (yet) at the level where i'm
> going to be able to contribute bleeding-edge code.  but i'm certainly
> capable of poring over the *existing* code and pointing out the places
> that might lead someone to mutter, "what the hell...?"
>
> maybe there's a better forum for me to make these observations.  i'm
> open to suggestions.  i've made a list of these observations and i'd
> be happy to send them to the right person.

Well, consult <http://kerneljanitors.org/>, or start to send patches.

My first step was to open top Makefile with emacs, and just to save file
(without even editing it). Resulting patch broke some old `make' on
Andrew Morton's test field:
<http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116198944205036&w=2>

That means top Makefile is writen with errors, somebody doesn't edit
kernel versions with "decent editor" (;

But it's working for many years and kernel versions. This yields, that
linux kernel is written by open source developers with help of users.
And it's written for to do the job. ^1

Do not expect much, just help with what you can. But i would suggest to
search archives, read sources (1.0, 2.0. 2.2, 2.4) + apply ^1 before any
questions.
____

