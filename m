Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279592AbRJXUjg>; Wed, 24 Oct 2001 16:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279591AbRJXUjY>; Wed, 24 Oct 2001 16:39:24 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:15607 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S279589AbRJXUjG>; Wed, 24 Oct 2001 16:39:06 -0400
Date: Wed, 24 Oct 2001 21:38:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcos Dione <mdione@hal.famaf.unc.edu.ar>, linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
Message-ID: <20011024213859.D2300@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar> <3BD4655E.82ED21CC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD4655E.82ED21CC@zip.com.au>; from akpm@zip.com.au on Mon, Oct 22, 2001 at 11:28:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 22, 2001 at 11:28:46AM -0700, Andrew Morton wrote:

> Yes, this is a bit of a problem - it's probably atime updates,

You can mount a filesystem with the "noatime" option, though.  That's
useful on laptops to stop read accesses from spinning up the disk.

Cheers,
 Stephen
