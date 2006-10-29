Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWJ2QSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWJ2QSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbWJ2QSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:18:23 -0500
Received: from main.gmane.org ([80.91.229.2]:35009 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965276AbWJ2QSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:18:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: why test for "__GNUC__"?
Date: Sun, 29 Oct 2006 16:17:51 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek9le5.2vm.olecom@flower.upol.cz>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain> <20061029120534.GA4906@martell.zuzino.mipt.ru> <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

On 2006-10-29, Robert P. J. Day wrote:
> On Sun, 29 Oct 2006, Alexey Dobriyan wrote:
>
>> On Sun, Oct 29, 2006 at 07:44:18AM -0500, Robert P. J. Day wrote:
>> > p.s.  is there, in fact, any part of the kernel source tree that has a
>> > preprocessor directive to identify the use of ICC?  just curious.
>>
>> Please, do
>>
>> 	ls include/linux/compiler-*
>
> but according to compiler.h:
>
> /* Intel compiler defines __GNUC__. So we will overwrite implementations
>  * coming from above header files here
>  */
>
> so even ICC will define __GNUC__, which means that testing for
> __GNUC__ is *still*, under the circumstances, redundant, isn't that
> right?

Does it introduce bugs? Just think of it as legacy, if you want.

And if you can, please, help with development or bugs, not this.
____

