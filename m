Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSLIOZp>; Mon, 9 Dec 2002 09:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSLIOZp>; Mon, 9 Dec 2002 09:25:45 -0500
Received: from [81.2.122.30] ([81.2.122.30]:14341 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265517AbSLIOZo>;
	Mon, 9 Dec 2002 09:25:44 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212091443.gB9EhcrH000900@darkstar.example.net>
Subject: Re: IDE feature request
To: hps@intermeta.de
Date: Mon, 9 Dec 2002 14:43:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <at28st$ifd$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Dec 09, 2002 02:21:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Fix ide.c to generate a b c d e f and you should be able to get 16.
> > Like this?
> Hmm,
> 
> you will get the same problem again, once someone is able to cram more than
> 16 IDE hosts into a box. Why not go for ide%d (ide0-9, ide10-99)?

The code that was posted did 0-9 then a-z, which is good for 36.  That
*should* be enough for most applications for a few years.

John.
