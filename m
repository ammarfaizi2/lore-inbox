Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270385AbUJUQ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbUJUQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270718AbUJUQwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:52:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268702AbUJUQsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:48:21 -0400
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>
Subject: Re: forcing PS/2 USB emulation off
References: <5F106036E3D97448B673ED7AA8B2B6B3017FC327@scl-exch2k.phoenix.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 21 Oct 2004 13:48:01 -0300
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3017FC327@scl-exch2k.phoenix.com>
Message-ID: <orhdoo5872.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2004, "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com> wrote:

>> It would be ok if someone bothered to copy the USB core code (or better
>> yet call into it) but the patch in the -mm tree doesn't know about the
>> zillion OHCI controller bugs, and doesn't know about the suprise
>> interrupt on switch from BIOS->host you sometimes see.

> Isn't this interrupt disabled at that point, and status are cleared
> right after handoff?

I've no idea, but as soon as I started using the USB handoff patch,
I've consistently got the K8 Errata #93 message as the first message
(or maybe one of the first few) I get on boot.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
