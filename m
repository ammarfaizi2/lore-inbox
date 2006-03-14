Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWCNCsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWCNCsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWCNCsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:48:32 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:20609 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1752126AbWCNCsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:48:31 -0500
Subject: Re: [Patch 9/9] Generic netlink interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1142303607.24621.63.camel@stark>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark>
Content-Type: text/plain
Organization: unknown
Date: Mon, 13 Mar 2006 21:48:26 -0500
Message-Id: <1142304506.5219.34.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-13-03 at 18:33 -0800, Matt Helsley wrote:
> On Mon, 2006-03-13 at 19:56 -0500, Shailabh Nagar wrote:

> Jamal, was your Mon, 13 Mar 2006 21:29:09 -0500 reply:
> > Note, you are still not following the standard scheme of doing things.
> > Example: using command = GET and the message carrying the TGID to note
> > which TGID is of interest. Instead you have command = TGID.
> > 

> meant to suggest that TASKSTATS_CMD_(P|TG)ID should be renamed to
> TASKSTATS_CMD_GET_(P|TG)ID ? Is that sufficient? Or am I
> misunderstanding?
> 

I had a long description in an earlier email feedback; but the summary
of it is the GET command is generic like TASKSTATS_CMD_GET; the message
itself carries TLVs of what needs to be gotten which are 
either PID and/or TGID etc. Anyways, theres a long spill of what i am
saying in that earlier email. Perhaps the current patch is a transition
towards that?

cheers,
jamal 

