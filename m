Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTJQP0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 11:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJQP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 11:26:37 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:62593 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263486AbTJQP0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 11:26:36 -0400
Date: Fri, 17 Oct 2003 16:27:57 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171527.h9HFRvU2001448@81-2-122-30.bradfords.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
In-Reply-To: <3F90025A.7070504@inet.com>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <3F8ECA3E.4030208@draigBrady.com>
 <20031016231235.GB29279@pegasys.ws>
 <200310170803.h9H83ahx000164@81-2-122-30.bradfords.org.uk>
 <3F90025A.7070504@inet.com>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The upshot of all that would be that if you needed space, it would be
> > there, (just overwrite the uncompressed versions of files), but until
> > you do, you can access the uncompressed data quickly.
> > 
> > You could even take it one step further, and compress files with gzip
> > by default, and re-compress them with bzip2 after long periods of
> > inactivity.
> 
> Note that a file compressed with bzip2 is not necessarily smaller than 
> the same file compressed with gzip.  (It can be quite a bit larger in fact.)

Have you noticed that with real-life data, or only test cases?

John.
