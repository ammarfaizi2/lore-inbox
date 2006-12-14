Return-Path: <linux-kernel-owner+w=401wt.eu-S932914AbWLNVNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWLNVNG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWLNVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:13:06 -0500
Received: from web50113.mail.yahoo.com ([206.190.39.150]:45678 "HELO
	web50113.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932914AbWLNVNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:13:05 -0500
Message-ID: <20061214211302.37455.qmail@web50113.mail.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ALtdrv32rHA/pxe1YvMi4TsH2qjOvTHkYXwd/0wlGCAlerzF1UR9nFr6SWqOeo5bE06v+b6DNUlxB6xDPrhXYoir6x4DjEInco9mDQNSXi8dGT32xjzkuep209R4g6hMwY8gcEiNuiN6ATltmHLg583VtUmdFlnCe0gS+XoRqL0=;
X-YMail-OSG: AE3e1GMVM1lDRLurrWntbBhC80PmLuP.nHMK.VmthY2.QtPu21tJ7XVhu5yoszpLHZK8.w8eV71QYQyCIcDJlKnOdeFgvsE33IBAb2Pcwnk5O4Nw4fRPZarKOjg75ZvZgNfyR95P9lE-
Date: Thu, 14 Dec 2006 13:13:02 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 3/3] EDAC: Add Fully-Buffered DIMM APIs to core
To: Andrew Morton <akpm@osdl.org>, Alan <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214130121.53a1776d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 14 Dec 2006 10:58:09 +0000
> Alan <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > > +void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
> > > +				unsigned int csrow,
> > > +				unsigned int channela,
> > > +				unsigned int channelb,
> > > +				char *msg)
> > > +{
> > > +	int len = EDAC_MC_LABEL_LEN * 4;
> > > +	char labels[len + 1];
> > 
> > Have you checked gcc generates the right code from this and not a
> dynamic
> > allocation. I'm not sure if you want "const int len" to force that
> ?
> 
> gcc does the right thing.  gcc-4.0.2 on x86_64, at least.
> 

should have indicated my version as well as working:
gcc version 4.1.0 (SUSE Linux)  x86_64

doug t


