Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbVG3TMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbVG3TMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVG3TFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:05:38 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:39845 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263110AbVG3TEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:04:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=sC+p5OMbMiHZVrAg1xnogYG6j+k43TbZueAkT23fbFhE9tbBRpdea24lMpADf6JiDiUk/aCCWulbxenwGfQGok4luE5Gccf+N/LJRcigyJ4TeBt23Pc9ID3BTSYXSaVJwu+AeCD71M477UpOny+DwDCjsYH0gA8SRaDN4mOp/To=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [patch 1/3] uml: share page bits handling between 2 and 3 level pagetables
Date: Sat, 30 Jul 2005 20:54:16 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
References: <20050728185655.9C6ADA3@zion.home.lan> <20050730160218.GB4585@ccure.user-mode-linux.org>
In-Reply-To: <20050730160218.GB4585@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302054.17118.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 July 2005 18:02, Jeff Dike wrote:
> On Thu, Jul 28, 2005 at 08:56:53PM +0200, blaisorblade@yahoo.it wrote:
> > As obvious, a "core code nice cleanup" is not a "stability-friendly
> > patch" so usual care applies.
>
> These look reasonable, as they are what we discussed in Ottawa.
>
> I'll put them in my tree and see if I see any problems.  I would
> suggest sending these in early after 2.6.13 if they seem OK.
Excluding the accessed handling it's ok, for the accessed handling I'm 
doubtful. Could you check if this was introduced recently (for instance by 
the introduction of flush_range_common, which IIRC is recent) or if it's old?

For instance, in latest 2.4, and/or in 2.6.9. If this is a regression the fix 
for accessed handling can be merged too.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
