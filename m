Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279287AbRJWGo1>; Tue, 23 Oct 2001 02:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279285AbRJWGoR>; Tue, 23 Oct 2001 02:44:17 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:5642 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S279288AbRJWGoG>; Tue, 23 Oct 2001 02:44:06 -0400
Date: Tue, 23 Oct 2001 08:44:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Why XFS not in the main kernel?
Message-ID: <20011023084433.D638@suse.de>
In-Reply-To: <20011023113546.A1310@bee.lk> <1003818066.1491.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1003818066.1491.2.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2001, Robert Love wrote:
> On Tue, 2001-10-23 at 01:35, Anuradha Ratnaweera wrote:
> > Is there a reason not to include XFS in the mainstream kernel?  It
> > is very stable and many (including us) are using it in production
> > environments without problems.
> > 
> > Obviously, there can't be liscening issues, because XFS is released
> > under GPL.
> 
> No one doubts XFS is stable.  It is a great fs.  But XFS includes some
> modifications to block layer and such that people aren't ready to

Not really the block layer -- this used to be the case. SGI kiobuf block
stuff was too ugly to live, and consequently it even died within the XFS
tree :)

-- 
Jens Axboe

