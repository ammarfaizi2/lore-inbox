Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSLCUy1>; Tue, 3 Dec 2002 15:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSLCUy1>; Tue, 3 Dec 2002 15:54:27 -0500
Received: from [209.184.141.189] ([209.184.141.189]:4958 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265865AbSLCUy0>;
	Tue, 3 Dec 2002 15:54:26 -0500
Subject: Re: 2.4.20-aa1 questions.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021203205830.A25661@infradead.org>
References: <1038948847.1772.7.camel@UberGeek>
	 <20021203205830.A25661@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038949286.2047.12.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 03 Dec 2002 15:01:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 14:58, Christoph Hellwig wrote:
> On Tue, Dec 03, 2002 at 02:54:08PM -0600, Austin Gonyou wrote:
> > what do the following patches actually *fix*?
> > 
> > 00_backout-gcc-3_0-patch-1
> > 00_gcc-30-volatile-xtime-1
> > 
> > I'm trying to get 2.4.20 patched up by using the -aa split patches for
> > 2.4.20 and I'm incorporating only the things I want, but I use gcc 3.2
> > for compiling, and these confused me a bit.
> 
> Oooh,  I had lengthy discussion with andrea on those two.  These patches
> are a) grossly misnamed and b) should be one.  They change xtime to a volatile
> because andrea thinks that's safer.
> 
> The background on the silly naming is that earlier 2.4 kernels had xtime
> not volatile but the prototype (or vice versa) and gcc3 didn't like that.

Ahh...kewl. thanks much. I was thinking that, but I was very confused by
the naming versus the code. (not that I was *that* sure of the code
anyway, but you know.) :)



> So the best idea would be to merge them into 00_xtime_volatile-1 if
> you want to keep them.

Ok...that sounds like a plan. Thanks so much.

-- 
GrandMasterLee <masterlee@digitalroadkill.net>
