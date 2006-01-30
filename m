Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWA3Kic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWA3Kic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWA3Kic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:38:32 -0500
Received: from isilmar.linta.de ([213.239.214.66]:56448 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932157AbWA3Kic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:38:32 -0500
Date: Mon, 30 Jan 2006 11:38:29 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       john.ronciak@intel.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: patch "e100: Fix TX hang and RMCP Ping issue" (post-2.6.16-rc1) causes suspend-to-ram breakage
Message-ID: <20060130103829.GA9564@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
	john.ronciak@intel.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20060129232537.GA8343@dominikbrodowski.de> <4807377b0601292344u5defbbcaw102cd16c49a82d67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0601292344u5defbbcaw102cd16c49a82d67@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 11:44:31PM -0800, Jesse Brandeburg wrote:
> On 1/29/06, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > Hi,
> >
> > git bisect revealed that 24180333206519e6b0c4633eab81e773b4527cac is
> > the first bad commit, which is
> >
> > "e100: Fix TX hang and RMCP Ping issue (due to a microcode loading issue)"
> 
> Thanks for the report, I think that we've already fixed this one. 
> Interestingly enough, it isn't a problem with the patch but a
> longstanding bug in the code that is triggered by the patch.
> 
> Please see:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113847804725851&w=2

Yes, thanks, this patch fixes it.

	Dominik
