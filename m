Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264609AbSIQVQJ>; Tue, 17 Sep 2002 17:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbSIQVQJ>; Tue, 17 Sep 2002 17:16:09 -0400
Received: from vena.lwn.net ([206.168.112.25]:27660 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S264609AbSIQVQI>;
	Tue, 17 Sep 2002 17:16:08 -0400
Message-ID: <20020917212109.14302.qmail@eklektix.com>
To: Mark C <gen-lists@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems accessing USB Mass Storage 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "17 Sep 2002 20:46:31 BST."
             <1032291993.1276.12.camel@stimpy.angelnet.internal> 
Date: Tue, 17 Sep 2002 15:21:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have also been advised by Jonathan Corbet 
> to use dd to copy your card to disk with an offset of 25
> 
> looking through the info and man pages for dd, I can find no mention of
> offset at all, the next best thing I could find was the command option
> 'skip'

That's what I meant.  Something like:

       dd if=/dev/sda of=/somewhere/image skip=25

If that works, please let me know - maybe there *is* a place for my hackish
fake partition table patch...

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
