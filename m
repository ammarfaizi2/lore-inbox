Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWCDBnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWCDBnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 20:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWCDBnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 20:43:43 -0500
Received: from ba.realmsys.com ([207.88.121.47]:46219 "EHLO ba.realmsys.com")
	by vger.kernel.org with ESMTP id S1751531AbWCDBnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 20:43:42 -0500
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
From: Thayne Harbaugh <thayne@realmsys.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       zhenyu.z.wang@intel.com
In-Reply-To: <200603031047.01445.dsp@llnl.gov>
References: <200603021748.01132.dsp@llnl.gov>
	 <20060302183044.459ddb13.akpm@osdl.org>  <200603031047.01445.dsp@llnl.gov>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 18:43:28 -0700
Message-Id: <1141436608.14012.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 10:47 -0800, Dave Peterson wrote:
> On Thursday 02 March 2006 18:30, Andrew Morton wrote:
> > Dave Peterson <dsp@llnl.gov> wrote:
> > >  +#ifdef CORRECT_BIOS
> > >  +fail0:
> > >  +#endif
> >
> > What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
> > commentary?  ;)
> 
> I'm not sure about this.  I'm cc'ing Thayne Harbaugh and Wang Zhenyu since
> their names are in the credits for the i82875p module.  Maybe they can
> provide some info.

This is something that is my style - I don't care for "#if 0" or "#if
1".  I usually drop a "#undef COMMENT_TAG" someplace with a "/* ... */"
comment next to it so that it's not some unknown tag.

I haven't looked through the code yet so I can't remember if it's
something I left and if it is, what it does.

I just looked, and I don't recognize it - "cvs annotate" lists it ass
being last touched by dsp_llnl ;^).


-- 
A silly version!
so I fix the stripping beat
with bitter sleep snot.

