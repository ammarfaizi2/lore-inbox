Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbUKQTtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUKQTtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUKQTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:47:15 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:58239 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262491AbUKQTph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:45:37 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Bug report for UML in latest Linus 2.6-BK repository.
Date: Wed, 17 Nov 2004 20:43:34 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
References: <1100612306.24599.37.camel@imp.csi.cam.ac.uk> <200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
In-Reply-To: <200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411172043.35481.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 November 2004 21:56, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > I get millions of these on the UML guest as soon as I start UML
> > (.config is below), notably HIGHMEM is not enabled in the .config.
> > They only stop when I shutdown.
>
> The patch below fixes those for me.

>     Jeff

Ok, yes... copy_from_user has never been atomic, and I should have remembered 
that. Sorry (anyway I wasn't going to fix that).

One more thing learned, anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
