Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSBANxM>; Fri, 1 Feb 2002 08:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291755AbSBANxD>; Fri, 1 Feb 2002 08:53:03 -0500
Received: from ns.suse.de ([213.95.15.193]:56078 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291758AbSBANwo>;
	Fri, 1 Feb 2002 08:52:44 -0500
Date: Fri, 1 Feb 2002 14:52:43 +0100
From: Dave Jones <davej@suse.de>
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3-dj7
Message-ID: <20020201145243.A20802@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Daniel E. Shipton" <dshipton@vrac.iastate.edu>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C59749C.B4855316@lbl.gov> <1012527802.8490.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012527802.8490.5.camel@localhost.localdomain>; from dshipton@vrac.iastate.edu on Thu, Jan 31, 2002 at 07:43:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 07:43:22PM -0600, Daniel E. Shipton wrote:
 > One of these days the kernel + modules will compile without error for
 > me.....

 I trust from $subject, you meant 2.5.3-dj1, or 2.5.2-dj7
 unless you are from the future 8-)

 Either way..
 > ataraid.c: In function `ataraid_make_request':
 > ataraid.c:105: structure has no member named `b_rdev'
 > ataraid.c:103: warning: `minor' might be used uninitialized in this
 > function

 ataraid needs some more TLC to make it work with the new block layer.
 Theres a bunch of parts that still need attention, and surprisingly
 some of the more common ones haven't been touched yet.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
