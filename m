Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbTLFL7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTLFL7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:59:37 -0500
Received: from main.gmane.org ([80.91.224.249]:6091 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265119AbTLFL7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:59:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: cdrecord hangs my computer
Date: Sat, 06 Dec 2003 12:59:33 +0100
Message-ID: <yw1xu14e88d6.fsf@kth.se>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
 <3FD1994C.10607@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:iYyC5K5z9oAPW37ZPeMxzjgLpEI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ethan Weinstein <lists@stinkfoot.org> writes:

>>>My system hangs everytime I try to  burn my .wav files to cd with cdrecord.
>>>Usually few tracks go succesfully but then everything stops. Even the mouse
>>>won't move and powerbutton does not affect.
>> Is this with ide-scsi? If so, does the appended patch help?
>> If not, we really need a whole lot more information (hw config,
>> messages
>> etc).
>
> I've noted this at boot several times with 2.6.0-test11
>
> Dec  4 23:59:21 e-d0uble kernel: ide-scsi is deprecated for cd
> burning! Use ide-cd and give dev=/dev/hdX as device

And cdrecord keeps saying "Warning: Open by 'devname' is unintentional
and not supported.".  Maybe it's about time someone got rid of that
message.

-- 
Måns Rullgård
mru@kth.se

