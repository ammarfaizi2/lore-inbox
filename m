Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbTBLMsu>; Wed, 12 Feb 2003 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbTBLMsu>; Wed, 12 Feb 2003 07:48:50 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:64908 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267078AbTBLMsr>;
	Wed, 12 Feb 2003 07:48:47 -0500
Date: Wed, 12 Feb 2003 12:54:26 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212125426.GA3770@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jamie Lokier <jamie@shareable.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212042143.GB9273@bjl1.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212042143.GB9273@bjl1.jlokier.co.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 04:21:43AM +0000, Jamie Lokier wrote:

 > > I feel I'm missing something obvious here, but is this part the
 > > low-hanging fruit that it seems ?
 > You have eliminated one MSR write very cleanly, although there are
 > still a few unnecessary conditionals when compared with grabbing a
 > whole branch of the fruit tree, as it were.
 > 
 > That leaves the other MSR write, which is also unnecessary.

Removing that one didn't seem quite so easy, so I wussed out.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
