Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWIMQMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWIMQMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWIMQMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:12:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750958AbWIMQMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:12:32 -0400
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to
	sockets	that are joined to group
From: Jeff Layton <jlayton@poochiereds.net>
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
References: <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 12:12:23 -0400
Message-Id: <1158163943.15449.75.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 07:32 -0700, David Stevens wrote:
> netdev-owner@vger.kernel.org wrote on 09/13/2006 07:13:55 AM:
>
>         This is not true on any OS I'm aware of, including the
> original sockets multicast implementation on early BSD.
> 

The current Linux behavior does seem to be consistent with the way
recent BSD and OSX seem to work. Solaris 8 seems to behave consistent
with the patch I posted.

Most of the RFC's I've looked at don't seem to have much to say about
how multicasting works at the socket level. Is there an RFC or
specification that spells this out, or is this one of those situations
where things are somewhat open to interpretation?

Thanks,
Jeff


