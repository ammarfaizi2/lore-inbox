Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTJQTwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTJQTwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:52:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17924 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263595AbTJQTwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:52:01 -0400
Date: Fri, 17 Oct 2003 20:50:09 +0100
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Otto Solares <solca@guug.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031017195008.GA11186@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@yahoo.com>,
	James Simmons <jsimmons@infradead.org>,
	Otto Solares <solca@guug.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Carlo E. Prelz" <fluido@fluido.as>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310171751200.966-100000@phoenix.infradead.org> <20031017193447.41865.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017193447.41865.qmail@web14911.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 12:34:47PM -0700, Jon Smirl wrote:
 > The people writing the AGP driver have added their ID's in the wrong format.
 > ATI wants the IDs in the two letter form, not family/chip.  The fbdev patch has
 > the ID's in correct form. The AGP driver should be the one that gets changed.

The ATI AGPGART driver _always_ used the format it currently does.
Since day 1, when it was written _by ATI engineers_
Your "ATI wants the IDs in two letter form" differs depending on which
ATI engineer you talk to it seems.

Personally, as agpgart maintainer, I couldn't care less what the defines
end up being, as long as it still compiles afterwards.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
