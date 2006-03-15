Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWCOEfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWCOEfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 23:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWCOEfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 23:35:19 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:37516 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1750951AbWCOEfR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 23:35:17 -0500
From: CIJOML <cijoml@volny.cz>
To: Peter Hagervall <hager@cs.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Dmesg is not showing whole boot list
Date: Wed, 15 Mar 2006 05:34:42 +0100
User-Agent: KMail/1.8.3
References: <200603140901.27746.cijoml@volny.cz> <20060314083812.GA27338@brainysmurf.cs.umu.se>
In-Reply-To: <20060314083812.GA27338@brainysmurf.cs.umu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603150534.42245.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This helped. 

Thanks

Michal

Dne út 14. bøezna 2006 09:38 jste napsal(a):
> On Tue, Mar 14, 2006 at 09:01:27AM +0100, CIJOML wrote:
> > Hello,
> >
> > maybe this si a wrong list to ask, bug after boot, dmesg shows that few
> > lines at the beginning are missing.
> >
> > Is there any option I can increase to get full dmesg?
>
> Try increasing CONFIG_LOG_BUF_SHIFT and recompile. That's likely the
> source of your problem.
>
>
>
> 	Peter Hagervall
