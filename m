Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVDET2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVDET2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVDETZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:25:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54185 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261738AbVDETOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:14:23 -0400
Date: Tue, 5 Apr 2005 10:55:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Gabor Z. Papp" <gzp@papp.hu>, Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30: pwc pwc_isoc_handler() called with status -84
Message-ID: <20050405135552.GB7409@logos.cnet>
References: <x6ekdqgyfm@gzp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x6ekdqgyfm@gzp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gabor, 

This seems to be a USB specific problem and my USB knowledge is null.

CCing Pete.

On Mon, Apr 04, 2005 at 08:59:57PM +0200, Gabor Z. Papp wrote:
> I have a Philips 750 webcam camera, equipped with a
> Sony CCD sensor + TDA878.
> 
> It was working fine with 2.4.29 and earlier kernels, often with
> 100-150 days uptime.
> 
> As I upgraded to 2.4.30-rc kernels, started getting such error in my
> kernel log:
> 
> pwc Too many ISOC errors, bailing out.
> pwc pwc_isoc_handler() called with status -84 [CRC/Timeout (could be anything)].
> 
> [khubd] got 100% cputime, and kernel just printed and printed this
> message to the log, generating huge files. :-)
> 
> rc4 is still doing this. 1-2 hour online, the something get mad and
> the pwc driver eat the cputime. 2.4.28 was 100% okay from this point
> of view.
> 
> http://gzp.odpn.net/tmp/pwc/
