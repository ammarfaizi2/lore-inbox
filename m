Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUHFRcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUHFRcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHFRbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:31:16 -0400
Received: from holomorphy.com ([207.189.100.168]:6094 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268199AbUHFR0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:26:13 -0400
Date: Fri, 6 Aug 2004 10:26:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Possible dcache BUG
Message-ID: <20040806172607.GO17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
	Chris Shoemaker <c.shoemaker@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org> <200408061316.24495.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061316.24495.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 12:58, Linus Torvalds wrote:
>> Now, Chris Shoemaker reported dentry problems on a intel CPU and
>> said that wli had seen something too, but I'm wondering whether
>> Chris and wli might have been seeing the knfsd/xfs-related dentry
>> bug that I found yesterday. So I think the prefetch theory is still
>> alive, but we should check with Chris. Chris?

On Fri, Aug 06, 2004 at 01:16:24PM -0400, Gene Heskett wrote:
> I'm still up, a bit over 24 hours now. :)  Free memory is slowly going 
> away, I ran mozilla for a while which got rid of about 60 megs, and 
> now I see I'm down to 23 free, whereas at the 11 hour up marker I had 
> nearly 130 megs free yet.  I've got to go to town, so that will leave 
> seti and kmail doing their thing till I get back.  If it goes down, 
> hopefully it will record something, unlike the last couple of times.

I've not had issues around the dcache for quite some time, I think not
since the 2.5.65 timeframe. IIRC maneesh and dipankar had some fixes
that resolved all my issues not long afterward. So unfortunately I have
nothing strictly dcache-related to report. Chris may have been
referring to some potentially pathological NFS behavior I've seen for a
long time centered around extended periods of knfsd unresponsiveness.

-- wli
