Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVKHHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVKHHGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbVKHHGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:06:24 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:1186 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965045AbVKHHGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:06:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] [MMC] wbsd pnp suspend
Date: Tue, 8 Nov 2005 02:06:21 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051108064100.18059.79712.stgit@poseidon.drzeus.cx> <20051107225019.7cd01a77.akpm@osdl.org> <43704C3D.30602@drzeus.cx>
In-Reply-To: <43704C3D.30602@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511080206.21831.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 01:57, Pierre Ossman wrote:
> Andrew Morton wrote:
> > Pierre Ossman <drzeus@drzeus.cx> wrote: 
> >> +	if (host->config != 0)
> >> +	{
> >> +		if (!wbsd_chip_validate(host))
> >> +		{
> > 
> > Like:
> > 
> > 	if (host->config != 0) {
> > 		if (!wbsd_chip_validate(host)) {
> > 
> > please.
> > 
> 
> We had this discussion the last patch for this driver. It's horribly 
> wrong when it comes to coding style so keeping patches in the same style 
> as the rest of the driver is the lesser evil (IMHO).
>

Aside from unusual brace placement it does not look too bad. How about
running it through Lindent to fix it once and for all?

-- 
Dmitry
