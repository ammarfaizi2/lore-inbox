Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSBDSrk>; Mon, 4 Feb 2002 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbSBDSra>; Mon, 4 Feb 2002 13:47:30 -0500
Received: from ns.suse.de ([213.95.15.193]:42002 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282845AbSBDSrU>;
	Mon, 4 Feb 2002 13:47:20 -0500
Date: Mon, 4 Feb 2002 19:47:19 +0100
From: Dave Jones <davej@suse.de>
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-dj2
Message-ID: <20020204194719.C11789@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Daniel E. Shipton" <dshipton@vrac.iastate.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020204154800.A13519@suse.de> <1012841649.8335.6.camel@regatta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012841649.8335.6.camel@regatta>; from dshipton@vrac.iastate.edu on Mon, Feb 04, 2002 at 10:54:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 10:54:09AM -0600, Daniel E. Shipton wrote:

 > /home/kernel/linux-2.5/include/linux/highmem.h:21: warning: implicit
 > declaration of function `bh_offset'

 Quick fix: add #include <linux/fs.h> to include/linux/highmem.h
 This is horrible though, I think its time to take another close
 look at fs.h

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
