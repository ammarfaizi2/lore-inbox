Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUHIO2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUHIO2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUHIO11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:27:27 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:47319 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266611AbUHIOYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:24:53 -0400
X-Sender-Authentication: net64
Date: Mon, 9 Aug 2004 16:24:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040809162449.51b13528.skraw@ithnet.com>
In-Reply-To: <200408091346.i79DkDRi010405@burner.fokus.fraunhofer.de>
References: <200408091346.i79DkDRi010405@burner.fokus.fraunhofer.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 15:46:13 +0200 (CEST)
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> >From: Stephan von Krawczynski <skraw@ithnet.com>
> 
> >Understand this: _nobody_ expects you to know everything about 25 different
> >OS's, the only thing that can be expected is that you simply listen to the
> >different parties knowing the different platforms and _take their advice_,
> >really not more.
> 
> While this works for most if not all OS, it does not work for Linux.
> 
> For Linux, the percentage of things that are reported incorrect to me is
> higher than 80%, so I need to use my own extertise. If I would not, cdrecord
> would be unusable.

If things are that bad, why don't you just take the easy path and let _others_
implement the linux-glue to your app ? All you have to do is to specify an
interface which is completely at your will.
Then, if something does not work out, it's not your problem. You can then
always draw the Solaris card and say "look, it works under solaris. So you (the
glue-author) must have made some mistake."

Regards,
Stephan
